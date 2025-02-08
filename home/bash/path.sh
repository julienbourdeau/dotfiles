#!/usr/bin/env bash

# Ruby
export PATH="$HOME/.rbenv/shims:$PATH"

# Homebrew bin directories
export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:$PATH"

SUBLIMEPATH=/Applications/'Sublime Text.app'/Contents/SharedSupport/bin
if [ -d "$SUBLIMEPATH" ]; then
	export PATH="$SUBLIMEPATH:$PATH"
fi

# Composer bin directory
export PATH="$HOME/.composer/vendor/bin:$PATH"

# Herd injected PHP binary.
export PATH="/Users/julien/Library/Application Support/Herd/bin/":$PATH

# Add MySQL
export PATH="$PATH:/opt/homebrew/mysql/bin:/opt/homebrew/opt/mysql@5.7/bin"

# Add Rust
export PATH="$PATH:$HOME/.cargo/bin"

# Google Cloud SDK
gcloudsdk="$(brew --prefix)/share/google-cloud-sdk/path.bash.inc"
if test -f "$gcloudsdk"; then
	source gcloudsdk
fi

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
MANPATH="/opt/homebrew/opt/findutils/libexec/gnuman:$MANPATH"
MANPATH="/opt/homebrew/opt/coreutils/libexec/gnuman:$MANPATH"

###############
#    GOPATH   #
###############

export GOPATH="$HOME/etc/go"
export PATH="$GOPATH/bin:$PATH:$GOROOT/bin"

###############
#     MISC    #
###############
