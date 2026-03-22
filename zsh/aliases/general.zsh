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

# Tmuxinator
alias mux="tmuxinator"

# Personal
alias sourcerc="source ~/.zshrc"
alias editrc="code ~/.zshrc"
alias op="xdg-open"

# alias tslam="/home/lotape6/.cache/bazel/_bazel_lotape6/5830f13868a98985169886d3e937ad75/execroot/_main/bazel-out/k8-fastbuild/bin/src/cli/taskslam-cli"
