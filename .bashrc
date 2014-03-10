# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# User specific aliases and functions

function bak() { cp "$1" "$1_`date +%Y-%m-%d_%H-%M-%S`" ; }
alias bak="bak"
alias vi='vim'
alias ll='ls -l'

# enable color support of ls
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
fi

alias ll='ls -l'
alias la='ls -A'
alias rm='rm --interactive --verbose'
alias wget='wget -c'
alias mv='mv --interactive --verbose'
alias cp='cp --verbose'
alias grep='grep -i --color'
alias 'stunnel'='while [ ! -f /tmp/sshuttle.pid ]; do sudo /usr/local/bin/sshuttle -r root@host -e '"'"'ssh -i ~/.ssh/id_rsa'"'"' 0.0.0.0/0 -v -x 192.168.0.0/24 --dns --daemon --pidfile=/tmp/sshuttle.pid && sleep 2; done && echo -n "Public IP: " && sleep 1 && curl icanhazip.com'
alias 'ktunnel'='[[ -f /tmp/sshuttle.pid ]] && sudo kill `cat /tmp/sshuttle.pid`'
alias tmux="TERM=screen-256color tmux"

export SVN_EDITOR=/usr/bin/vim
export EDITOR=/usr/bin/vim

source ~/.liquidprompt

# Python virtualenv wrapper
export WORKON_HOME=~/.virtualenvs
source /usr/bin/virtualenvwrapper.sh

# Extend PATH
export PATH=$PATH:~/bin

# Extend env
source ~/bin/setenv

if [ -e /usr/share/terminfo/x/xterm-256color ]; then
    export TERM='xterm-256color'
else
    export TERM='xterm-color'
fi

