# Peach theme — Kanagawa Wave palette
# Warm ambers, peaches, and crystal blues on a deep ink background

export THEME_BG="#1f1f28"
export THEME_SURFACE="#2a2a37"
export THEME_OVERLAY="#363646"
export THEME_FG="#dcd7ba"
export THEME_ACCENT="#ffa066"      # surimiOrange / peach
export THEME_SECONDARY="#ff9e64"   # peachRed
export THEME_BLUE="#7e9cd8"        # crystalBlue
export THEME_CYAN="#6a9589"        # waveAqua
export THEME_GREEN="#98bb6c"       # springGreen
export THEME_YELLOW="#e6c384"      # carpYellow
export THEME_RED="#e46876"
export THEME_ORANGE="#ffa066"

# FZF colors
export THEME_FZF_COLORS="fg:#dcd7ba,bg:#1f1f28,hl:#ffa066,fg+:#dcd7ba,bg+:#2a2a37,hl+:#ff9e64,info:#7e9cd8,prompt:#ffa066,pointer:#ff9e64,marker:#98bb6c,spinner:#7e9cd8,header:#7e9cd8,border:#363646,gutter:#1f1f28"

# zsh-autosuggestions
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#363646"

# zsh-syntax-highlighting
typeset -A ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[command]="fg=#7e9cd8,bold"
ZSH_HIGHLIGHT_STYLES[builtin]="fg=#ffa066,bold"
ZSH_HIGHLIGHT_STYLES[function]="fg=#7e9cd8"
ZSH_HIGHLIGHT_STYLES[alias]="fg=#98bb6c"
ZSH_HIGHLIGHT_STYLES[keyword]="fg=#e46876,bold"
ZSH_HIGHLIGHT_STYLES[string]="fg=#98bb6c"
ZSH_HIGHLIGHT_STYLES[path]="fg=#dcd7ba,underline"
ZSH_HIGHLIGHT_STYLES[comment]="fg=#363646"
ZSH_HIGHLIGHT_STYLES[variable]="fg=#ff9e64"
ZSH_HIGHLIGHT_STYLES[assign]="fg=#e6c384"
ZSH_HIGHLIGHT_STYLES[redirection]="fg=#6a9589"
ZSH_HIGHLIGHT_STYLES[commandseparator]="fg=#e46876"
ZSH_HIGHLIGHT_STYLES[single-hyphen-option]="fg=#ffa066"
ZSH_HIGHLIGHT_STYLES[double-hyphen-option]="fg=#ffa066"
ZSH_HIGHLIGHT_STYLES[unknown-token]="fg=#e46876,bold,underline"
