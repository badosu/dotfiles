#
# Sets Oh My Zsh options.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#
export OMZ="$HOME/.oh-my-zsh"

# Set the key mapping style to 'emacs' or 'vi'.
zstyle ':omz:module:editor' keymap 'vi'

# Auto convert .... to ../..
zstyle ':omz:module:editor' dot-expansion 'no'

# Set case-sensitivity for completion, history lookup, etc.
zstyle ':omz:*:*' case-sensitive 'no'

# Color output (auto set to 'no' on dumb terminals).
zstyle ':omz:*:*' color 'yes'

# Auto set the tab and window titles.
zstyle ':omz:module:terminal' auto-title 'yes'

# Set the Zsh modules to load (man zshmodules).
# zstyle ':omz:load' zmodule 'attr' 'stat'

# Set the Zsh functions to load (man zshcontrib).
# zstyle ':omz:load' zfunction 'zargs' 'zmv'

# Set the Oh My Zsh modules to load (browse modules).
# The order matters.
zstyle ':omz:load' omodule \
  'environment' \
  'terminal' \
  'editor' \
  'history' \
  'directory' \
  'spectrum' \
  'utility' \
  'git' \
  'ruby' \
  'rails' \
  'completion' \
  'prompt'

# Set the prompt theme to load.
# Setting it to 'random' loads a random theme.
# Auto set to 'off' on dumb terminals.
zstyle ':omz:module:prompt' theme 'sorin'

# This will make you shout: OH MY ZSHELL!
source "$OMZ/init.zsh"

alias irc="$HOME/.irc-script/irssi-connect.sh"
alias be="bundle exec"
alias ack="ack-grep"

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
PATH=$PATH:$HOME/.cabal/bin # Adds Cabal bin

# Search backwards and forwards with a pattern
bindkey -M vicmd '/' history-incremental-pattern-search-forward
bindkey -M vicmd '?' history-incremental-pattern-search-backward
#
# # set up for insert mode too
bindkey -M viins '^R' history-incremental-pattern-search-backward
bindkey -M viins '^F' history-incremental-pattern-search-forward

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

alias eclimd="~/.eclipse/org.eclipse.platform_3.7.0_155965261/eclimd"
