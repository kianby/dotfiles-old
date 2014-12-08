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
alias vi='gvim -v'
alias vim='gvim -v'
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

export SVN_EDITOR=/usr/bin/vim
export EDITOR=/usr/bin/vim

source ~/.liquidprompt

# Python virtualenv wrapper
export WORKON_HOME=~/.virtualenvs
source /usr/bin/virtualenvwrapper.sh

# Extend Env
source ~/bin/setenv

# Workaround for GDM issue ignoring Xresources macros
xrdb -merge ~/.Xresources

