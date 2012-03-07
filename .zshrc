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

# Customize to your needs...
export PATH=/home/amadeus/.rvm/bin:/usr/lib/lightdm/lightdm:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games

# rvm
[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"

# aliases
alias g="git status"
alias gg="gitg"
alias ga="git add"
alias gp="git push"
alias gd="git diff"
alias gc="git commit"
alias gs="git log -p -1 --pretty=oneline --decorate"
alias gl="git log --graph --pretty=oneline --decorate"

alias irc="$HOME/.irc-script/irssi-connect.sh"

alias be="bundle exec"

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
PATH=$PATH:$HOME/.cabal/bin # Adds Cabal bin

set -o vi
