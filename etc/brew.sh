#!/usr/bin/env bash

# Make sure we’re using the latest Homebrew
brew update

# Upgrade any already-installed formulae
brew upgrade

# Install GNU core utilities (those that come with OS X are outdated)
brew install coreutils
echo "Don’t forget to add $(brew --prefix coreutils)/libexec/gnubin to \$PATH."
# Install GNU `find`, `locate`, `updatedb`, and `xargs`, g-prefixed
brew install findutils
# Install Bash 4
brew install bash

# Install wget with IRI support
brew install wget --enable-iri


brew tap homebrew/versions
brew install lua52

# Install other useful binaries
brew install ack
brew install exiv2
brew install imagemagick
brew install lynx
brew install ngrep
brew install mhash
#brew install osxfuse
brew install vim
brew install nmap

brew install git
brew install hub
brew install trash
brew install composer
brew install wp-cli


brew tap josegonzalez/homebrew-php
brew install php55
brew install php55-intl
brew install php55-mcrypt
brew install php55-xdebug



# Install native apps
brew tap phinze/homebrew-cask
brew install brew-cask

function installcask() {
	brew cask install "${@}" 2> /dev/null
}

installcask google-chrome
installcask iterm2
installcask tor-browser
installcask transmission
installcask virtualbox
installcask vlc

# Alfed won't see apps installed with Homebrew Cask
# You have to link it with:
# brew cask alfred link

# Remove outdated versions from the cellar
brew cleanup
