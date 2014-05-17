# Antigen
source ~/work/coding/gitclones/antigen/antigen.zsh

# Load the oh-my-zsh's library.
antigen use oh-my-zsh

# ** prefix prompt
DEFAULT_USER="yannic"
export DEFAULT_USER

# Load the theme.
antigen theme http://git.olivierdelort.net/colmaris/colmaris-zsh.git colmaris
#antigen theme agnoster

# Bundles from the default repo (robbyrussell's oh-my-zsh).
antigen  bundles <<EOBUNDLES

# version control system
git
git-extras
svn-fast-info

mvn
pip
command-not-found

EOBUNDLES

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

# Enable completion for new installed command within the session by
# not trust the zsh's cache of executable command, and forced it be
# updated
zstyle ":completion:*:commands" rehash 1


