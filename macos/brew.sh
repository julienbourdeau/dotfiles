#!/usr/bin/env bash

# Install command-line tools using Homebrew.

# Make sure we’re using the latest Homebrew.
brew update

# Upgrade any already-installed formulae.
brew upgrade

# Install GNU core utilities (those that come with OS X are outdated).
# Don’t forget to add `$(brew --prefix coreutils)/libexec/gnubin` to `$PATH`.
brew install coreutils

# Install some other useful utilities like `sponge`.
brew install moreutils

# Install GNU `find`, `locate`, `updatedb`, and `xargs`, `g`-prefixed.
brew install findutils

# Install GNU bin utils -> http://www.gnu.org/software/binutils/
brew install binutils


# Install Bash
# Note: don’t forget to add `/usr/local/bin/bash` to `/etc/shells` before
# running `chsh`.
brew install bash


# Install more recent versions of some OS X tools.
brew install vim
brew install wget
brew install gnu-sed
brew install grep
brew install openssh
brew install screen

# Install font tools.
brew tap bramstein/webfonttools
brew install sfnt2woff
brew install sfnt2woff-zopfli
brew install woff2

# Install PHP 7
brew install php
brew install composer
brew install wp-cli

# Install git tools
brew install git
brew install git-lfs
brew install hub
# brew install bfg # requires Java
brew install git-open

# Install latest nodejs
brew install nvm

# Install latest ruby
brew install ruby

# Install latest go
brew install go

# Install databases
brew install sqlite
brew install redis
brew install postgresql
brew install mysql@5.7


# Install completion
brew install bash-completion2
brew install brew-cask-completion
brew install bundler-completion
brew install vagrant-completion
brew install wpcli-completion


# Install compression tools
brew install p7zip
brew install zopfli
brew install xz
brew install brotli

# Install other useful binaries.
brew install jq
brew install bat
brew install autojump
brew install heroku
brew install httpie
brew install asciinema
brew install tldr
brew install codemod
brew install htop-osx
brew install nmap
brew install ack
brew install lynx
brew install pv
brew install rename
brew install speedtest_cli
brew install ssh-copy-id
brew install tree
brew install trash
brew install terminal-notifier
brew install gnupg2
brew install shellcheck

# Install Mackup to restore/backup some apps config
brew install mackup

# Remove outdated versions from the cellar.
brew cleanup
