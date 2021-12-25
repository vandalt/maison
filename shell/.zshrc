HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000

setopt autocd

bindkey -e

zstyle ':compinstall:*' menu select
autoload -Uz compinit
compinit

if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

setopt CORRECT_ALL
