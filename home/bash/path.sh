#!/usr/bin/env bash

# Ruby
export PATH="$HOME/.rbenv/shims:$PATH"

# Homebrew bin directories
export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:$PATH"


# Composer bin directory
export PATH="$HOME/.composer/vendor/bin:$PATH"


# Add Rust
export PATH="$PATH:$HOME/.cargo/bin"


#custom path
export PATH="$PATH:$HOME/.bin:$HOME/bin"

# Use GNU utils
PATH="/opt/homebrew/opt/coreutils/libexec/gnubin:$PATH"
PATH="/opt/homebrew/opt/findutils/libexec/gnubin:$PATH"
PATH="/opt/homebrew/opt/gnu-sed/libexec/gnubin:$PATH"

###############
#   MANPATH   #
###############

# Manpages for GNU utils
#TODO: Add MANPAGE TO FISH
MANPATH="/opt/homebrew/opt/findutils/libexec/gnuman:$MANPATH"
MANPATH="/opt/homebrew/opt/coreutils/libexec/gnuman:$MANPATH"

###############
#    GOPATH   #
###############


###############
#     MISC    #
###############
