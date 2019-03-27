#!/usr/bin/env bash

# Ruby and RVM
# Might need to change it to be the last PATH variable change.
export PATH="/usr/local/opt/ruby/bin:$HOME/.rvm/bin:$PATH"

# Homebrew bin directories
export PATH="/usr/local/bin:/usr/local/sbin:$PATH";

# Composer bin directory
export PATH="$HOME/.composer/vendor/bin:$PATH";

# Add MySQL
export PATH="$PATH:/usr/local/mysql/bin"

# Add Rust
export PATH="$PATH:$HOME/.cargo/bin"

#custom path
export PATH="$PATH:$HOME/.bin:$HOME/bin";


# Use GNU utils
PATH="/usr/local/opt/findutils/libexec/gnubin:$PATH"
PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"


###############
#   MANPATH   #
###############

# Manpages for GNU utils
MANPATH="/usr/local/opt/findutils/libexec/gnuman:$MANPATH"
MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"


###############
#    GOPATH   #
###############

export GOPATH="$HOME/etc/go"
export PATH="$GOPATH/bin:$PATH:$GOROOT/bin";


###############
#     MISC    #
###############

export NVM_DIR="$HOME/.nvm"

