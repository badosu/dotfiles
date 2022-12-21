# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Use powerline
USE_POWERLINE="true"
# Source manjaro-zsh-configuration
if [[ -e /usr/share/zsh/manjaro-zsh-config ]]; then
  source /usr/share/zsh/manjaro-zsh-config
fi
# Use manjaro zsh prompt
if [[ -e /usr/share/zsh/manjaro-zsh-prompt ]]; then
  source /usr/share/zsh/manjaro-zsh-prompt
fi

set -o vi
bindkey -v
bindkey '\e[3~' delete-char
bindkey '^R' history-incremental-search-backward

alias vim=nvim
alias ch='cd ~/Code/$(ls ~/Code | fzf)'
alias gpu='git pull'
alias gcl='git clone'
alias gco='git commit'
alias gd='git diff'
alias gf='git fetch'
alias gl='git log'
alias gr='git reset'
alias gs='git stash'
alias gp='git push'
alias gc='git checkout'
alias ga='git add'
alias gb='git branch'
alias gbb='gc $(gb | fzf)'
alias g='git status'

export PATH="/home/badosu/.local/share/gem/ruby/3.0.0/bin:$PATH"
export GEM_HOME="/home/badosu/.local/share/gem/ruby/3.0.0/bundle"

dca() {
  service="${1}"
  containerid=$(docker ps | grep $service | awk '{print $1}')

  [ -z "$containerid" ] && echo "No running instance for $service" && return

  echo "Attached to container $containerid for $service"

  docker attach --sig-proxy=true $containerid
}

dcu() {
  docker-compose up -d "${1}"
}

dce() {
  docker-compose exec "${1}" $@
}

dct() {
  docker-compose run -e RAILS_ENV=test "${1}" "${2:-sh}"
}


PATH="/home/badosu/perl5/bin${PATH:+:${PATH}}"; export PATH;
PERL5LIB="/home/badosu/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="/home/badosu/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"/home/badosu/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/home/badosu/perl5"; export PERL_MM_OPT;

function osc7 {
    local LC_ALL=C
    export LC_ALL

    setopt localoptions extendedglob
    input=( ${(s::)PWD} )
    uri=${(j::)input/(#b)([^A-Za-z0-9_.\!~*\'\(\)-\/])/%${(l:2::0:)$(([##16]#match))}}
    print -n "\e]7;file://${HOSTNAME}${uri}\e\\"
}
add-zsh-hook -Uz chpwd osc7

precmd() {
    print -Pn "\e]133;A\e\\"
}

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

source ~/.zsh/catppuccin_mocha-zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
