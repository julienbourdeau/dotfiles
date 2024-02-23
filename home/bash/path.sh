#!/usr/bin/env bash

# Ruby
export PATH="$HOME/.rbenv/shims:$PATH"

# Homebrew bin directories
export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:$PATH";

# Composer bin directory
export PATH="$HOME/.composer/vendor/bin:$PATH";

# Add MySQL
export PATH="$PATH:/opt/homebrew/mysql/bin:/opt/homebrew/opt/mysql@5.7/bin"

# Add Rust
export PATH="$PATH:$HOME/.cargo/bin"

# Google Cloud SDK
source "$(brew --prefix)/share/google-cloud-sdk/path.bash.inc"

#custom path
export PATH="$PATH:$HOME/.bin:$HOME/bin";


# Use GNU utils
PATH="/opt/homebrew/opt/coreutils/libexec/gnubin:$PATH"
PATH="/opt/homebrew/opt/findutils/libexec/gnubin:$PATH"
PATH="/opt/homebrew/opt/gnu-sed/libexec/gnubin:$PATH"


###############
#   MANPATH   #
###############

# Manpages for GNU utils
MANPATH="/opt/homebrew/opt/findutils/libexec/gnuman:$MANPATH"
MANPATH="/opt/homebrew/opt/coreutils/libexec/gnuman:$MANPATH"


###############
#    GOPATH   #
###############

export GOPATH="$HOME/etc/go"
export PATH="$GOPATH/bin:$PATH:$GOROOT/bin";


###############
#     MISC    #
###############

export NVM_DIR="$HOME/.nvm"

