#!/usr/bin/env bash
#
# install.sh — OS-agnostic dotfiles bootstrap
#
# Usage: curl -fsSL <raw-url>/install.sh | bash
#    or: ./install.sh
#
# Idempotent: safe to run multiple times.

set -euo pipefail

BASEDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# ─── Colors ───────────────────────────────────────────────────────────────────

_color() { printf '\033[%sm%s\033[0m\n' "$1" "$2"; }
info()  { _color "34" "[info]  $1"; }
ok()    { _color "32" "[ok]    $1"; }
warn()  { _color "33" "[warn]  $1"; }
err()   { _color "31" "[error] $1"; }

# ─── OS / Package-Manager Detection ──────────────────────────────────────────

detect_os() {
  case "$(uname -s)" in
    Darwin) OS=macos ;;
    Linux)  OS=linux ;;
    *)      err "Unsupported OS: $(uname -s)"; exit 1 ;;
  esac
}

detect_pkg_manager() {
  if [ "$OS" = "macos" ]; then
    PKG=brew
    return
  fi

  if command -v apt-get >/dev/null 2>&1; then
    PKG=apt
  elif command -v dnf >/dev/null 2>&1; then
    PKG=dnf
  elif command -v pacman >/dev/null 2>&1; then
    PKG=pacman
  else
    err "No supported package manager found (apt, dnf, pacman, brew)"
    exit 1
  fi
}

# ─── Package Installation ────────────────────────────────────────────────────

PACKAGES=(zsh tmux fzf git stow fd ripgrep bat htop tealdeer)

# Map generic names → distro-specific names where they differ.
pkg_name() {
  local name="$1"
  case "$PKG" in
    apt)
      case "$name" in
        fd)        echo "fd-find"   ;;
        ripgrep)   echo "ripgrep"   ;;
        bat)       echo "bat"       ;;
        tealdeer)  echo "tealdeer"  ;;
        *)         echo "$name"     ;;
      esac
      ;;
    dnf)
      case "$name" in
        fd)        echo "fd-find"   ;;
        tealdeer)  echo "tealdeer"  ;;
        *)         echo "$name"     ;;
      esac
      ;;
    pacman)
      case "$name" in
        fd)        echo "fd"        ;;
        tealdeer)  echo "tealdeer"  ;;
        *)         echo "$name"     ;;
      esac
      ;;
    brew)
      case "$name" in
        tealdeer)  echo "tealdeer"  ;;
        *)         echo "$name"     ;;
      esac
      ;;
  esac
}

install_packages() {
  info "Installing packages via $PKG …"

  local to_install=()
  for p in "${PACKAGES[@]}"; do
    to_install+=("$(pkg_name "$p")")
  done

  case "$PKG" in
    apt)
      sudo apt-get update -qq
      sudo apt-get install -y -qq "${to_install[@]}"
      ;;
    dnf)
      sudo dnf install -y -q "${to_install[@]}"
      ;;
    pacman)
      sudo pacman -Syu --noconfirm --needed "${to_install[@]}"
      ;;
    brew)
      install_homebrew
      brew install "${to_install[@]}" 2>/dev/null || true
      ;;
  esac

  ok "Packages installed"
}

install_homebrew() {
  if command -v brew >/dev/null 2>&1; then
    return
  fi
  info "Installing Homebrew …"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  # Ensure brew is on PATH for the rest of this script
  if [ -x /opt/homebrew/bin/brew ]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
  elif [ -x /usr/local/bin/brew ]; then
    eval "$(/usr/local/bin/brew shellenv)"
  fi
  ok "Homebrew installed"
}

# ─── Oh My Zsh ───────────────────────────────────────────────────────────────

install_omz() {
  if [ -d "${HOME}/.oh-my-zsh" ]; then
    ok "Oh My Zsh already installed"
    return
  fi
  info "Installing Oh My Zsh …"
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
  ok "Oh My Zsh installed"
}

# ─── Starship Prompt ─────────────────────────────────────────────────────────

install_starship() {
  if command -v starship >/dev/null 2>&1; then
    ok "Starship already installed"
    return
  fi
  info "Installing Starship prompt …"
  curl -sS https://starship.rs/install.sh | sh -s -- --yes
  ok "Starship installed"
}

# ─── Cheat ───────────────────────────────────────────────────────────────────

install_cheat() {
  if command -v cheat >/dev/null 2>&1; then
    ok "cheat already installed"
    return
  fi
  info "Installing cheat …"

  local tmp
  tmp="$(mktemp -d)"
  trap 'rm -rf "$tmp"' RETURN

  local arch
  case "$(uname -m)" in
    x86_64)  arch=amd64 ;;
    aarch64|arm64) arch=arm64 ;;
    *) err "Unsupported architecture: $(uname -m)"; return 1 ;;
  esac

  local os
  case "$(uname -s)" in
    Darwin) os=darwin ;;
    Linux)  os=linux ;;
    *) err "Unsupported OS for cheat: $(uname -s)"; return 1 ;;
  esac

  local url="https://github.com/cheat/cheat/releases/latest/download/cheat-${os}-${arch}.gz"
  curl -fsSL "$url" -o "${tmp}/cheat.gz"
  gunzip "${tmp}/cheat.gz"
  chmod +x "${tmp}/cheat"
  sudo mv "${tmp}/cheat" /usr/local/bin/cheat

  ok "cheat installed"
}

# ─── Backup Existing Dotfiles ────────────────────────────────────────────────

backup_existing_dotfiles() {
  local backup_dir="${HOME}/.dotfiles.bak"
  local targets=(
    ~/.zshrc
    ~/.tmux.conf
    ~/.tmux.conf.local
    ~/.fzf.zsh
    ~/.gitconfig
    ~/.gitignore_global
    ~/.config/starship.toml
  )
  local needed=false

  for f in "${targets[@]}"; do
    f="${f/#\~/$HOME}"
    # Back up regular files/dirs that aren't already symlinks
    if [ -e "$f" ] && [ ! -L "$f" ]; then
      needed=true
      break
    fi
  done

  if [ "$needed" = false ]; then
    return
  fi

  mkdir -p "$backup_dir"
  info "Backing up existing dotfiles to $backup_dir …"

  for f in "${targets[@]}"; do
    f="${f/#\~/$HOME}"
    if [ -e "$f" ] && [ ! -L "$f" ]; then
      mv "$f" "$backup_dir/"
      info "  Backed up $(basename "$f")"
    fi
  done

  ok "Existing dotfiles backed up"
}

# ─── Dotbot Symlinks ─────────────────────────────────────────────────────────

run_dotbot() {
  info "Running Dotbot …"
  cd "${BASEDIR}"
  git -C "${BASEDIR}" submodule sync --quiet --recursive
  git submodule update --init --recursive "${BASEDIR}"
  "${BASEDIR}/dotbot/bin/dotbot" -d "${BASEDIR}" -c install.conf.yaml
  ok "Dotbot symlinks created"
}

# ─── Default Shell ────────────────────────────────────────────────────────────

set_default_shell() {
  local zsh_path
  zsh_path="$(command -v zsh)"

  if [ "$(basename "$SHELL")" = "zsh" ]; then
    ok "Default shell is already zsh"
    return
  fi

  info "Setting default shell to zsh …"

  # Ensure zsh is in /etc/shells
  if ! grep -qx "$zsh_path" /etc/shells 2>/dev/null; then
    echo "$zsh_path" | sudo tee -a /etc/shells >/dev/null
  fi

  chsh -s "$zsh_path"
  ok "Default shell set to zsh (takes effect on next login)"
}

# ─── Main ─────────────────────────────────────────────────────────────────────

main() {
  info "Dotfiles bootstrap starting …"

  detect_os
  detect_pkg_manager
  info "Detected OS=$OS, package manager=$PKG"

  install_packages
  install_cheat
  install_omz
  install_starship
  backup_existing_dotfiles
  run_dotbot
  set_default_shell

  ok "Bootstrap complete!"
}

main "$@"
