# Lavender theme — Catppuccin Mocha palette
# Soft purples, mauves, and pinks on a deep plum background

export THEME_BG="#1e1e2e"
export THEME_SURFACE="#313244"
export THEME_OVERLAY="#45475a"
export THEME_FG="#cdd6f4"
export THEME_ACCENT="#cba6f7"      # mauve
export THEME_SECONDARY="#f5c2e7"   # pink
export THEME_BLUE="#89b4fa"
export THEME_CYAN="#89dceb"
export THEME_GREEN="#a6e3a1"
export THEME_YELLOW="#f9e2af"
export THEME_RED="#f38ba8"
export THEME_ORANGE="#fab387"

# FZF colors
export THEME_FZF_COLORS="fg:#cdd6f4,bg:#1e1e2e,hl:#cba6f7,fg+:#cdd6f4,bg+:#313244,hl+:#f5c2e7,info:#89b4fa,prompt:#cba6f7,pointer:#f5c2e7,marker:#a6e3a1,spinner:#89b4fa,header:#89b4fa,border:#45475a,gutter:#1e1e2e"

# zsh-autosuggestions
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#45475a"

# zsh-syntax-highlighting
typeset -A ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[command]="fg=#89b4fa,bold"
ZSH_HIGHLIGHT_STYLES[builtin]="fg=#cba6f7,bold"
ZSH_HIGHLIGHT_STYLES[function]="fg=#89b4fa"
ZSH_HIGHLIGHT_STYLES[alias]="fg=#a6e3a1"
ZSH_HIGHLIGHT_STYLES[keyword]="fg=#f38ba8,bold"
ZSH_HIGHLIGHT_STYLES[string]="fg=#a6e3a1"
ZSH_HIGHLIGHT_STYLES[path]="fg=#cdd6f4,underline"
ZSH_HIGHLIGHT_STYLES[comment]="fg=#45475a"
ZSH_HIGHLIGHT_STYLES[variable]="fg=#f5c2e7"
ZSH_HIGHLIGHT_STYLES[assign]="fg=#f9e2af"
ZSH_HIGHLIGHT_STYLES[redirection]="fg=#89dceb"
ZSH_HIGHLIGHT_STYLES[commandseparator]="fg=#f38ba8"
ZSH_HIGHLIGHT_STYLES[single-hyphen-option]="fg=#fab387"
ZSH_HIGHLIGHT_STYLES[double-hyphen-option]="fg=#fab387"
ZSH_HIGHLIGHT_STYLES[unknown-token]="fg=#f38ba8,bold,underline"
