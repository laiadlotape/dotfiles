# Rose theme — Rosé Pine palette
# Warm roses, golds, and foamy blues on a deep burgundy night

export THEME_BG="#191724"
export THEME_SURFACE="#26233a"
export THEME_OVERLAY="#403d52"
export THEME_FG="#e0def4"
export THEME_ACCENT="#eb6f92"      # love / rose
export THEME_SECONDARY="#f6c177"   # gold
export THEME_BLUE="#9ccfd8"        # foam
export THEME_CYAN="#ebbcba"        # rose pale
export THEME_GREEN="#31748f"       # pine
export THEME_YELLOW="#f6c177"
export THEME_RED="#eb6f92"
export THEME_ORANGE="#ea9a97"

# FZF colors
export THEME_FZF_COLORS="fg:#e0def4,bg:#191724,hl:#eb6f92,fg+:#e0def4,bg+:#26233a,hl+:#f6c177,info:#9ccfd8,prompt:#eb6f92,pointer:#f6c177,marker:#31748f,spinner:#9ccfd8,header:#9ccfd8,border:#403d52,gutter:#191724"

# zsh-autosuggestions
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#403d52"

# zsh-syntax-highlighting
typeset -A ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[command]="fg=#9ccfd8,bold"
ZSH_HIGHLIGHT_STYLES[builtin]="fg=#eb6f92,bold"
ZSH_HIGHLIGHT_STYLES[function]="fg=#9ccfd8"
ZSH_HIGHLIGHT_STYLES[alias]="fg=#31748f"
ZSH_HIGHLIGHT_STYLES[keyword]="fg=#eb6f92,bold"
ZSH_HIGHLIGHT_STYLES[string]="fg=#31748f"
ZSH_HIGHLIGHT_STYLES[path]="fg=#e0def4,underline"
ZSH_HIGHLIGHT_STYLES[comment]="fg=#403d52"
ZSH_HIGHLIGHT_STYLES[variable]="fg=#ebbcba"
ZSH_HIGHLIGHT_STYLES[assign]="fg=#f6c177"
ZSH_HIGHLIGHT_STYLES[redirection]="fg=#9ccfd8"
ZSH_HIGHLIGHT_STYLES[commandseparator]="fg=#eb6f92"
ZSH_HIGHLIGHT_STYLES[single-hyphen-option]="fg=#ea9a97"
ZSH_HIGHLIGHT_STYLES[double-hyphen-option]="fg=#ea9a97"
ZSH_HIGHLIGHT_STYLES[unknown-token]="fg=#eb6f92,bold,underline"
