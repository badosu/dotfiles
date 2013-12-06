#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#
# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Customize to your needs...

PATH=$PATH:$HOME/.cabal/bin # Adds own bin

# Search backwards and forwards with a pattern
bindkey -M vicmd '/' history-incremental-pattern-search-forward
bindkey -M vicmd '?' history-incremental-pattern-search-backward
#
# # set up for insert mode too
bindkey -M viins '^R' history-incremental-pattern-search-backward
bindkey -M viins '^F' history-incremental-pattern-search-forward

# editor
export VISUAL=gvim
export EDITOR=gvim

# aliases
alias rm="rm -f"
alias be="bundle exec"

alias g="git status"
alias gg="gitg"
alias ga="git add"
alias gp="git push"
alias gd="git diff"
alias gc="git checkout"
alias gco="git commit"
alias gcl="git clone"
alias gpu="git pull"
alias gs="git stash"
alias gl="git log --oneline --decorate"
alias gr="git reset"
alias gb="git branch"

set -o vi
