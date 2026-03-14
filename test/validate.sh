#!/usr/bin/env bash
#
# validate.sh — Verify dotfiles installation
#
# Checks symlinks, tool availability, config syntax, and shell loading.
# Can be run locally or inside a Docker container for OS-agnostic verification.
#
# Usage:
#   ./test/validate.sh              # Run all checks
#   docker run --rm -v "$PWD":/dotfiles ubuntu bash /dotfiles/test/validate.sh
#

set -uo pipefail

PASS=0
FAIL=0
WARN=0

# ─── Output ──────────────────────────────────────────────────────────────────

_color() { printf '\033[%sm%s\033[0m\n' "$1" "$2"; }
pass() { _color "32" "[PASS] $1"; ((PASS++)); }
fail() { _color "31" "[FAIL] $1"; ((FAIL++)); }
warn() { _color "33" "[WARN] $1"; ((WARN++)); }
info() { _color "34" "[INFO] $1"; }

# ─── Symlink Checks ─────────────────────────────────────────────────────────

check_symlinks() {
  info "Checking symlinks …"

  local -A links=(
    ["$HOME/.zshrc"]="zsh/zshrc"
    ["$HOME/.zsh/aliases"]="zsh/aliases"
    ["$HOME/.zsh/functions"]="zsh/functions"
    ["$HOME/.tmux.conf"]="tmux/tmux.conf"
    ["$HOME/.tmux.conf.local"]="tmux/tmux.conf.local"
    ["$HOME/.fzf.zsh"]="fzf/fzf.zsh"
    ["$HOME/.gitconfig"]="git/gitconfig"
    ["$HOME/.gitignore_global"]="git/gitignore_global"
    ["$HOME/.config/starship.toml"]="starship/starship.toml"
  )

  for target in "${!links[@]}"; do
    if [ -L "$target" ]; then
      pass "Symlink exists: $target"
    elif [ -e "$target" ]; then
      warn "Exists but not a symlink: $target"
    else
      fail "Missing: $target"
    fi
  done
}

# ─── Tool Availability ──────────────────────────────────────────────────────

check_tools() {
  info "Checking required tools …"

  local tools=(zsh tmux fzf git)
  for tool in "${tools[@]}"; do
    if command -v "$tool" >/dev/null 2>&1; then
      pass "$tool installed ($(command -v "$tool"))"
    else
      fail "$tool not found"
    fi
  done

  # Starship (installed via curl, may not be present in minimal containers)
  if command -v starship >/dev/null 2>&1; then
    pass "starship installed"
  else
    warn "starship not found (optional — installed via curl)"
  fi
}

# ─── Oh-My-Zsh ──────────────────────────────────────────────────────────────

check_omz() {
  info "Checking Oh-My-Zsh …"

  if [ -d "$HOME/.oh-my-zsh" ]; then
    pass "Oh-My-Zsh directory exists"
  else
    fail "Oh-My-Zsh not installed (~/.oh-my-zsh missing)"
  fi

  if [ -f "$HOME/.oh-my-zsh/oh-my-zsh.sh" ]; then
    pass "oh-my-zsh.sh present"
  else
    fail "oh-my-zsh.sh missing"
  fi
}

# ─── TPM ─────────────────────────────────────────────────────────────────────

check_tpm() {
  info "Checking TPM (Tmux Plugin Manager) …"

  local tpm_dir="$HOME/.tmux/plugins/tpm"
  if [ -d "$tpm_dir" ]; then
    pass "TPM directory exists"
  else
    fail "TPM not installed ($tpm_dir missing)"
  fi

  if [ -x "$tpm_dir/tpm" ]; then
    pass "TPM executable found"
  else
    warn "TPM executable not found (plugins may not load)"
  fi
}

# ─── Zsh Config Syntax ──────────────────────────────────────────────────────

check_zshrc() {
  info "Checking .zshrc syntax …"

  if ! command -v zsh >/dev/null 2>&1; then
    warn "zsh not installed — skipping syntax check"
    return
  fi

  if [ ! -f "$HOME/.zshrc" ]; then
    fail ".zshrc not found — skipping syntax check"
    return
  fi

  # -n: parse without executing (syntax check only)
  if zsh -n "$HOME/.zshrc" 2>/dev/null; then
    pass ".zshrc parses without syntax errors"
  else
    fail ".zshrc has syntax errors"
  fi
}

# ─── Tmux Config Syntax ─────────────────────────────────────────────────────

check_tmux_config() {
  info "Checking tmux config syntax …"

  if ! command -v tmux >/dev/null 2>&1; then
    warn "tmux not installed — skipping config check"
    return
  fi

  if [ ! -f "$HOME/.tmux.conf" ]; then
    fail ".tmux.conf not found — skipping config check"
    return
  fi

  # Parse config without starting a server (-f for config, source-file to parse)
  # Use a throwaway server socket to avoid interfering with running sessions
  local sock="/tmp/validate-tmux-$$"
  if tmux -S "$sock" -f "$HOME/.tmux.conf" start-server \; kill-server 2>/dev/null; then
    pass "tmux.conf parses without errors"
  else
    # tmux may fail due to missing plugins (TPM), which is expected
    # Check if the error is just about missing plugin scripts
    local err
    err=$(tmux -S "$sock" -f "$HOME/.tmux.conf" start-server \; kill-server 2>&1 || true)
    if echo "$err" | grep -q "tpm"; then
      warn "tmux.conf has TPM-related warnings (run prefix+I to install plugins)"
    else
      fail "tmux.conf has parse errors: $err"
    fi
  fi
  rm -f "$sock"
}

# ─── Git Config ──────────────────────────────────────────────────────────────

check_git_config() {
  info "Checking git config …"

  if ! command -v git >/dev/null 2>&1; then
    warn "git not installed — skipping config check"
    return
  fi

  if [ ! -f "$HOME/.gitconfig" ]; then
    fail ".gitconfig not found"
    return
  fi

  # Verify git can parse the config
  if git config --file "$HOME/.gitconfig" --list >/dev/null 2>&1; then
    pass ".gitconfig parses correctly"
  else
    fail ".gitconfig has parse errors"
  fi
}

# ─── FZF Config ──────────────────────────────────────────────────────────────

check_fzf_config() {
  info "Checking FZF configuration …"

  if [ -f "$HOME/.fzf.zsh" ]; then
    pass "FZF config file exists (~/.fzf.zsh)"
  else
    fail "FZF config missing (~/.fzf.zsh)"
  fi
}

# ─── Starship Config ────────────────────────────────────────────────────────

check_starship_config() {
  info "Checking Starship configuration …"

  if [ -f "$HOME/.config/starship.toml" ]; then
    pass "Starship config exists"
  else
    fail "Starship config missing (~/.config/starship.toml)"
  fi

  # Validate TOML syntax if starship is installed
  if command -v starship >/dev/null 2>&1 && [ -f "$HOME/.config/starship.toml" ]; then
    if STARSHIP_CONFIG="$HOME/.config/starship.toml" starship print-config >/dev/null 2>&1; then
      pass "Starship config valid TOML"
    else
      fail "Starship config has errors"
    fi
  fi
}

# ─── Main ────────────────────────────────────────────────────────────────────

main() {
  info "Dotfiles validation starting …"
  echo

  check_symlinks
  echo
  check_tools
  echo
  check_omz
  echo
  check_tpm
  echo
  check_zshrc
  echo
  check_tmux_config
  echo
  check_git_config
  echo
  check_fzf_config
  echo
  check_starship_config

  echo
  echo "──────────────────────────────────────"
  info "Results: $PASS passed, $FAIL failed, $WARN warnings"

  if [ "$FAIL" -gt 0 ]; then
    _color "31" "VALIDATION FAILED"
    exit 1
  else
    _color "32" "VALIDATION PASSED"
    exit 0
  fi
}

main "$@"
