# Mint theme — Everforest palette
# Natural sage greens, warm ivory, and cool aquas on a forest dark background

export THEME_BG="#1e2326"
export THEME_SURFACE="#272e33"
export THEME_OVERLAY="#374145"
export THEME_FG="#d3c6aa"
export THEME_ACCENT="#83c092"      # aqua
export THEME_SECONDARY="#a7c080"   # green
export THEME_BLUE="#7fbbb3"
export THEME_CYAN="#83c092"
export THEME_GREEN="#a7c080"
export THEME_YELLOW="#dbbc7f"
export THEME_RED="#e67e80"
export THEME_ORANGE="#e69875"

# FZF colors
export THEME_FZF_COLORS="fg:#d3c6aa,bg:#1e2326,hl:#83c092,fg+:#d3c6aa,bg+:#272e33,hl+:#a7c080,info:#7fbbb3,prompt:#83c092,pointer:#a7c080,marker:#dbbc7f,spinner:#7fbbb3,header:#7fbbb3,border:#374145,gutter:#1e2326"

# zsh-autosuggestions
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#374145"

# zsh-syntax-highlighting
typeset -A ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[command]="fg=#7fbbb3,bold"
ZSH_HIGHLIGHT_STYLES[builtin]="fg=#83c092,bold"
ZSH_HIGHLIGHT_STYLES[function]="fg=#7fbbb3"
ZSH_HIGHLIGHT_STYLES[alias]="fg=#a7c080"
ZSH_HIGHLIGHT_STYLES[keyword]="fg=#e67e80,bold"
ZSH_HIGHLIGHT_STYLES[string]="fg=#a7c080"
ZSH_HIGHLIGHT_STYLES[path]="fg=#d3c6aa,underline"
ZSH_HIGHLIGHT_STYLES[comment]="fg=#374145"
ZSH_HIGHLIGHT_STYLES[variable]="fg=#83c092"
ZSH_HIGHLIGHT_STYLES[assign]="fg=#dbbc7f"
ZSH_HIGHLIGHT_STYLES[redirection]="fg=#7fbbb3"
ZSH_HIGHLIGHT_STYLES[commandseparator]="fg=#e67e80"
ZSH_HIGHLIGHT_STYLES[single-hyphen-option]="fg=#e69875"
ZSH_HIGHLIGHT_STYLES[double-hyphen-option]="fg=#e69875"
ZSH_HIGHLIGHT_STYLES[unknown-token]="fg=#e67e80,bold,underline"
