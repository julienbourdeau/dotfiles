
# Install GNU core utilities (those that come with OS X are outdated).
# Don't install `binutils` it messes with Ruby installation
brew "coreutils"
brew "moreutils"
brew "findutils"

# Install git tools
brew "git"
brew "git-open"
brew "git-delta"

# Install Fish for my main prompt
brew "fish"
brew "fisher"
brew "terminal-notifier"

# Install Bash because macos default is old
# Add `/usr/local/bin/bash` to `/etc/shells` before running `chsh`.
brew "bash"

# Install compression tools
brew "p7zip"
brew "zopfli"
brew "xz"
brew "brotli"

# Formatters
brew "shfmt"
brew "yamllint"
brew "shellcheck"

# Databases
brew "sqlite"
brew "postgresql" # always run in docker but this installs lib

brew "jq"
brew "pv"
brew "awk"
brew "bat"
brew "vim"
brew "wget"
brew "grep"
brew "tlrc"
brew "tree"
brew "screen"
brew "rename"
brew "httpie"
brew "gnu-sed"
brew "openssh"
brew "htop-osx"
brew "ssh-copy-id"
brew "shared-mime-info"


# Install dev tools

brew "mise"
cask "herd"
cask "iterm2"
cask "cyberduck"
cask "tableplus"
cask "sourcetree"
cask "sublime-text"
cask "1password-cli"

# Install other softwares

cask "hey-desktop"
cask "vlc"
cask "tyke"
cask "zoom"
cask "slack"
cask "signal"
cask "alfred"
cask "calibre"
cask "dropbox"
cask "spotify"
cask "whatsapp"
cask "pocket-casts"

# Fonts
cask "font-jetbrains-mono"
# cask "font-meslo-lg-nerd-font"
# cask "font-jetbrains-mono-nerd-font"


# Mac App Store

mas "Dato", id: 1470584107
mas "Things 3", id: 904280696
mas "Amphetamine", id: 937984704
mas "The Unarchiver", id: 425424353 # Best app ever
mas "1Password for Safari", id: 1569813296

mas "CANAL+", id: 694580816
mas "Infuse", id: 1136220934
mas "Amazon Prime Video", id: 545519333
