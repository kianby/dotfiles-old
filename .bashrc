# .bashrc

# User specific aliases and functions

function bak() { cp "$1" "$1_`date +%Y-%m-%d_%H-%M-%S`" ; }
alias bak="bak"

alias vi='vim'
alias ll='ls -l'
alias rm='rm --interactive --verbose'
alias wget='wget -c'
alias mv='mv --interactive --verbose'
alias cp='cp --verbose'
alias grep='grep -i --color'
alias 'stunnel'='while [ ! -f /tmp/sshuttle.pid ]; do sudo /usr/local/bin/sshuttle -r root@toulon-rau -e '"'"'ssh -i /home/yannic/.ssh/id_rsa'"'"' 0.0.0.0/0 -v -x 192.168.0.0/24 --dns --daemon --pidfile=/tmp/sshuttle.pid && sleep 2; done && echo -n "Public IP: " && sleep 1 && curl icanhazip.com'
alias 'ktunnel'='[[ -f /tmp/sshuttle.pid ]] && sudo kill `cat /tmp/sshuttle.pid`'

export SVN_EDITOR=/usr/bin/vim

source ~/.liquidprompt

# Python virtualenv wrapper
export WORKON_HOME=~/.virtualenvs
source /usr/bin/virtualenvwrapper.sh

# Extend PATH
export PATH=$PATH:~/bin

# Extend env
source ~/bin/setenv
