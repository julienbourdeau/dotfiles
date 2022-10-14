#!/usr/bin/env bash

# Ruby and RVM
# Might need to change it to be the last PATH variable change.
export PATH="$HOME/.rvm/bin:/usr/local/opt/ruby/bin:$PATH"

# Homebrew bin directories
export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:$PATH";

# Composer bin directory
export PATH="$HOME/.composer/vendor/bin:$PATH";

# Add MySQL
export PATH="$PATH:/opt/homebrew/mysql/bin:/opt/homebrew/opt/mysql@5.7/bin"

# Add Rust
export PATH="$PATH:$HOME/.cargo/bin"

#custom path
export PATH="$PATH:$HOME/.bin:$HOME/bin";


# Use GNU utils
PATH="/opt/homebrew/opt/findutils/libexec/gnubin:$PATH"
PATH="/opt/homebrew/opt/coreutils/libexec/gnubin:$PATH"


###############
#   MANPATH   #
###############

# Manpages for GNU utils
MANPATH="/opt/homebrew/opt/findutils/libexec/gnuman:$MANPATH"
MANPATH="/opt/homebrew/opt/coreutils/libexec/gnuman:$MANPATH"

  export NVM_DIR="$HOME/.nvm"
  [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
  [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

###############
#    GOPATH   #
###############

export GOPATH="$HOME/etc/go"
export PATH="$GOPATH/bin:$PATH:$GOROOT/bin";


###############
#     MISC    #
###############

export NVM_DIR="$HOME/.nvm"

