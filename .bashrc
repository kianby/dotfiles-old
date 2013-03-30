# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# User specific aliases and functions

#source ~/prompt.bash

function bak() { cp "$1" "$1_`date +%Y-%m-%d_%H-%M-%S`" ; }
alias bak="bak"

alias rm='rm --interactive --verbose'
alias wget='wget -c'
alias mv='mv --interactive --verbose'
alias cp='cp --verbose'
alias grep='grep -i --color'

export SVN_EDITOR=/usr/bin/vim

source ~/.liquidprompt
