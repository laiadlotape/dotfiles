# ~/.fzf.zsh - FZF configuration and shell integration
# Managed by dotfiles

# --- Default Command ---
# Use fd instead of find for better performance and respecting .gitignore
export FZF_DEFAULT_COMMAND='fd --type f --strip-cwd-prefix --hidden --follow --exclude .git'

# --- Aesthetic Theme ---
export FZF_DEFAULT_OPTS=" \
  --reverse \
  --border rounded \
  --info inline \
  --height 40% \
  --margin 0,1 \
  --padding 0 \
  --prompt '∷ ' \
  --pointer '▶' \
  --marker '✓' \
  --color fg:-1,bg:-1,hl:#5f87af \
  --color fg+:#d0d0d0,bg+:#262626,hl+:#5fd7ff \
  --color info:#afaf87,prompt:#d7005f,pointer:#af5fff \
  --color marker:#87ff00,spinner:#af5fff,header:#87afaf \
  --bind 'ctrl-/:toggle-preview'"

# --- Key Bindings ---
# CTRL-T: Paste selected files/dirs onto command line
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_T_OPTS=" \
  --preview 'bat --style=numbers --color=always --line-range :500 {} 2>/dev/null || cat {}' \
  --bind 'ctrl-/:change-preview-window(down|hidden|)'"

# CTRL-R: Search command history
export FZF_CTRL_R_OPTS=" \
  --preview 'echo {}' \
  --preview-window up:3:hidden:wrap \
  --bind 'ctrl-/:toggle-preview'"

# ALT-C: cd into selected directory
export FZF_ALT_C_COMMAND='fd --type d --strip-cwd-prefix --hidden --follow --exclude .git'
export FZF_ALT_C_OPTS=" \
  --preview 'ls -la --color=always {} | head -20'"

# --- Custom Completion Functions ---
# Use fd for path completion (e.g., vim **<TAB>)
_fzf_compgen_path() {
  fd --hidden --follow --exclude .git . "$1"
}

# Use fd for directory completion (e.g., cd **<TAB>)
_fzf_compgen_dir() {
  fd --type d --hidden --follow --exclude .git . "$1"
}

# --- Tmux Integration ---
# Use tmux popup for fzf when running inside tmux
export FZF_TMUX_OPTS="-p 80%,60%"

# --- Source FZF Shell Integration ---
# Keybindings and completion (location varies by install method)
if [[ -f "${HOME}/.fzf/shell/key-bindings.zsh" ]]; then
  source "${HOME}/.fzf/shell/key-bindings.zsh"
fi
if [[ -f "${HOME}/.fzf/shell/completion.zsh" ]]; then
  source "${HOME}/.fzf/shell/completion.zsh"
fi
# Homebrew install location
if [[ -f "/opt/homebrew/opt/fzf/shell/key-bindings.zsh" ]]; then
  source "/opt/homebrew/opt/fzf/shell/key-bindings.zsh"
fi
if [[ -f "/opt/homebrew/opt/fzf/shell/completion.zsh" ]]; then
  source "/opt/homebrew/opt/fzf/shell/completion.zsh"
fi
# Package manager install location
if [[ -f "/usr/share/fzf/key-bindings.zsh" ]]; then
  source "/usr/share/fzf/key-bindings.zsh"
fi
if [[ -f "/usr/share/fzf/completion.zsh" ]]; then
  source "/usr/share/fzf/completion.zsh"
fi
