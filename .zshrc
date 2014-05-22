#### interactive shell check #### {
if [[ $- != *i* ]] ; then
    return
fi
#### end interactive check #### }
#
# Antigen
source ~/.antigen/antigen.zsh

# Load the oh-my-zsh's library.
antigen use oh-my-zsh

# ** prefix prompt
DEFAULT_USER="yannic"
export DEFAULT_USER

# Bundles from the default repo (robbyrussell's oh-my-zsh).
antigen bundles <<EOBUNDLES

nojhan/liquidprompt

# version control system
git
svn

# python
pip
fabric
virtualenv
virtualenvwrapper

# java
mvn

tmux
command-not-found

EOBUNDLES

# detect version
if [ -f /etc/debian_version ]; then
    antigen bundle debian
elif [ -f /etc/redhat-release ]; then
    antigen bundle yum
else
    antigen bundle archlinux
fi

# Syntax highlighting bundle.
antigen bundle zsh-users/zsh-syntax-highlighting

# History substring search
antigen bundle zsh-users/zsh-history-substring-search
bindkey '^[[A' history-substring-search-up # Set for key up
bindkey '^[[B' history-substring-search-down # Set for key down

# * Completions
# Additional completion definitions for Zsh.
antigen bundle zsh-users/zsh-completions src

# Tell antigen that you're done.
antigen apply

setopt nocorrectall
unsetopt beep
unsetopt SHARE_HISTORY

# Enable completion for new installed command within the session by
# not trust the zsh's cache of executable command, and forced it be
# updated
zstyle ":completion:*:commands" rehash 1

# Editors
export SVN_EDITOR=/usr/bin/vim
export EDITOR=/usr/bin/vim

# Virtualenv
export WORKON_HOME=~/.virtualenvs
source /usr/bin/virtualenvwrapper.sh

# Extend PATH
export PATH=$PATH:~/bin

# Useful functions
function bak() { cp "$1" "$1_`date +%Y-%m-%d_%H-%M-%S`" ; }
alias bak="bak"
alias vi='vim'

