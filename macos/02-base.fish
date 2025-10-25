#!/usr/bin/env fish

if not command -sq brew
    echo "Error: Homebrew is not installed. Please install Homebrew first."
    exit 1
end

# Install GNU core utilities (those that come with OS X are outdated).
# Don't install `binutils` it messes with Ruby installation
brew install coreutils moreutils findutils

# Install git tools
brew install git
brew install git-open git-delta

# Install Bash
# Add `/usr/local/bin/bash` to `/etc/shells` before running `chsh`.
brew install bash

# Install more recent versions of some OS X tools.
brew install vim wget gnu-sed grep openssh screen


# Install compression tools
brew install p7zip zopfli xz brotli

# Formatters
brew install shfmt
brew install yamllint
brew install shellcheck

# Databases
brew install sqlite
brew install postgresql # always run in docker but this installs lib

# Install other useful binaries.
brew install jq
brew install pv
brew install bat
brew install tree
brew install tlrc
brew install rename
brew install httpie
brew install htop-osx
brew install ssh-copy-id
brew install shared-mime-info

brew install 1password-cli

# Remove outdated versions from the cellar.
brew cleanup
