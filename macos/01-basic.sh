#!/usr/bin/env bash

source "./00-brew.sh"

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
# Add `/usr/local/bin/bash` to `/etc/shells` before running `chsh`.
brew install bash


# Install more recent versions of some OS X tools.
brew install vim
brew install wget
brew install gnu-sed
brew install grep
brew install openssh
brew install screen

# Install font tools.
# brew tap bramstein/webfonttools
# brew install sfnt2woff
# brew install sfnt2woff-zopfli
# brew install woff2


# Install git tools
brew install git
brew install git-open
brew install git-delta


# Install compression tools
brew install p7zip
brew install zopfli
brew install xz
brew install brotli

# Install other useful binaries.
brew install jq
brew install bat
brew install httpie
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
brew install gnupg2
brew install shellcheck
brew install vault
brew install yamllint
brew install shared-mime-info

brew install 1password-cli

# Remove outdated versions from the cellar.
brew cleanup
