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

PATH=$PATH:$HOME/bin # Adds own bin
PATH=$PATH:$HOME/.cabal/bin # Adds Cabal bin
PATH=$PATH:$HOME/.rvm/bin # Adds RVM bin

# Search backwards and forwards with a pattern
bindkey -M vicmd '/' history-incremental-pattern-search-forward
bindkey -M vicmd '?' history-incremental-pattern-search-backward
#
# # set up for insert mode too
bindkey -M viins '^R' history-incremental-pattern-search-backward
bindkey -M viins '^F' history-incremental-pattern-search-forward

# editor
export VISUAL=vi
export EDITOR=vi

# aliases
alias git-submodule-rm="git-submodule-rm.sh"
alias irc="irssi-connect.sh"
alias ack="ack-grep"
alias rm="rm -f"
alias be="bundle exec"
alias eclimd="~/.eclipse/org.eclipse.platform_3.7.0_155965261/eclimd"

alias g="git status"
alias gg="gitg"
alias ga="git add"
alias gp="git push"
alias gd="git diff"
alias gc="git checkout"
alias gco="git commit"
alias gcl="git clone"
alias gpu="git pull"
alias gs="git log -p -1 --pretty=oneline --decorate"
alias gl="git log --graph --pretty=oneline --decorate"

function dump {
    if [ -z "$1" ]; then
        echo "App name should be given"
    else
        heroku pgbackups:capture --expire -a $1
        curl -o latest.dump `heroku pgbackups:url -a "$1"`
    fi
}
 
function restore_db {
    pg_restore -h localhost --verbose --clean --no-acl --no-owner -d $1 $2
}
