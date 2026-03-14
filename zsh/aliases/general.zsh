# General aliases

# Navigation
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."

# Listing
alias ll="ls -alF"
alias la="ls -A"
alias l="ls -CF"

# Safety
alias rm="rm -i"
alias cp="cp -i"
alias mv="mv -i"

# Convenience
alias cls="clear"
alias h="history"
alias j="jobs -l"
alias path='echo -e "${PATH//:/\\n}"'
