# Install homebrew if not found
if ! command -v brew &> /dev/null
then
    echo "Installing Homebrew"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    if [ ! -f "/opt/homebrew/bin/brew" ]; then
      eval "$(/opt/homebrew/bin/brew shellenv)"
      $(/opt/homebrew/bin/brew shellenv)
    fi

    if [ ! -f "/usr/local/Homebrew/bin/brew" ]; then
      eval "$(/usr/local/Homebrew/bin/brew shellenv)"
      $(/usr/local/Homebrew/bin/brew shellenv)
    fi
fi

# Make sure we’re using the latest Homebrew.
brew update

# Upgrade any already-installed formulae.
brew upgrade
