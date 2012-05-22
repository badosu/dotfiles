# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme
ZSH_THEME="gallois"

# Uncomment following line if you want red dots to be displayed while waiting for completion
COMPLETION_WAITING_DOTS="true"

# ~/.oh-my-zsh/plugins/*
plugins=(git gem rvm vi-mode)

source $ZSH/oh-my-zsh.sh

source /etc/profile.d/rvm.sh

# aliases
alias g="git status"
alias gg="gitg"
alias ga="git add"
alias gp="git push"
alias gd="git diff"
alias gc="git commit"
alias gcl="git clone"
alias gpu="git pull"
alias gs="git log -p -1 --pretty=oneline --decorate"
alias gl="git log --graph --pretty=oneline --decorate"

alias irc="$HOME/.irc-script/irssi-connect.sh"

alias be="bundle exec"

alias ack="ack-grep"

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
PATH=$PATH:$HOME/.cabal/bin # Adds Cabal bin

set -o vi

# Search backwards and forwards with a pattern
bindkey -M vicmd '/' history-incremental-pattern-search-forward
bindkey -M vicmd '?' history-incremental-pattern-search-backward
#
# # set up for insert mode too
bindkey -M viins '^R' history-incremental-pattern-search-backward
bindkey -M viins '^F' history-incremental-pattern-search-forward
