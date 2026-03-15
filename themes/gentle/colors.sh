# Gentle theme — terminal-default neutral palette
# Uses terminal fg/bg for maximum compatibility; muted highlights for any dark terminal

# FZF colors — terminal defaults for bg/fg, muted neutral highlights
export THEME_FZF_COLORS="fg:-1,bg:-1,hl:#5f87af,fg+:#d0d0d0,bg+:#262626,hl+:#5fd7ff,info:#afaf87,prompt:#5f87af,pointer:#af5fff,marker:#87ff00,spinner:#af5fff,header:#87afaf,border:#3a3a3a,gutter:-1"

# zsh-autosuggestions
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#4e4e4e"

# zsh-syntax-highlighting
typeset -A ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[command]="fg=#5f87af,bold"
ZSH_HIGHLIGHT_STYLES[builtin]="fg=#af5fff,bold"
ZSH_HIGHLIGHT_STYLES[function]="fg=#5f87af"
ZSH_HIGHLIGHT_STYLES[alias]="fg=#5faf5f"
ZSH_HIGHLIGHT_STYLES[keyword]="fg=#d7005f,bold"
ZSH_HIGHLIGHT_STYLES[string]="fg=#5faf5f"
ZSH_HIGHLIGHT_STYLES[path]="fg=#d0d0d0,underline"
ZSH_HIGHLIGHT_STYLES[comment]="fg=#4e4e4e"
ZSH_HIGHLIGHT_STYLES[variable]="fg=#af5fff"
ZSH_HIGHLIGHT_STYLES[assign]="fg=#afaf87"
ZSH_HIGHLIGHT_STYLES[redirection]="fg=#5f87af"
ZSH_HIGHLIGHT_STYLES[commandseparator]="fg=#d7005f"
ZSH_HIGHLIGHT_STYLES[single-hyphen-option]="fg=#d7875f"
ZSH_HIGHLIGHT_STYLES[double-hyphen-option]="fg=#d7875f"
ZSH_HIGHLIGHT_STYLES[unknown-token]="fg=#d7005f,bold,underline"
