# Utility functions

# tmux-sessionizer — Alt+q keybinding for outside tmux
# Inside tmux the binding is handled by tmux.conf (display-popup -E).
# Outside tmux we need a zsh widget so fzf gets a proper TTY.
_tmux_sessionizer() {
  ~/.local/bin/tmux-sessionizer
  zle reset-prompt
}
zle -N _tmux_sessionizer
bindkey '\eq' _tmux_sessionizer

# Create directory and cd into it
mkcd() {
  mkdir -p "$1" && cd "$1"
}

# Extract various archive formats
extract() {
  if [[ -f "$1" ]]; then
    case "$1" in
      *.tar.bz2) tar xjf "$1" ;;
      *.tar.gz)  tar xzf "$1" ;;
      *.tar.xz)  tar xJf "$1" ;;
      *.bz2)     bunzip2 "$1" ;;
      *.gz)      gunzip "$1" ;;
      *.tar)     tar xf "$1" ;;
      *.tbz2)    tar xjf "$1" ;;
      *.tgz)     tar xzf "$1" ;;
      *.zip)     unzip "$1" ;;
      *.Z)       uncompress "$1" ;;
      *.7z)      7z x "$1" ;;
      *)         echo "'$1' cannot be extracted" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

# Find a file by name
ff() {
  find . -type f -name "*$1*"
}

# Find a directory by name
fd() {
  find . -type d -name "*$1*"
}
