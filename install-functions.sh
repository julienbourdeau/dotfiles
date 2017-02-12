#!/usr/bin/env bash

switch_to_homebrew_bash() {
  if ! fgrep -q '/usr/local/bin/bash' /etc/shells; then
    echo '/usr/local/bin/bash' | sudo tee -a /etc/shells;
    chsh -s /usr/local/bin/bash;
  fi;
}

link() {
  from="$1"
  to="$2"
  echo "Linking '$from' to '$to'"
  rm -f "$to"
  ln -s "$from" "$to"
}

sulink() {
  from="$1"
  to="$2"
  echo "Linking '$from' to '$to'"
  sudo rm -f "$to"
  sudo ln -s "$from" "$to"
}

symlink_host_file() {
  sudo cp -f /etc/hosts /etc/hosts.orig
  sulink "$dotfiles/etc/hosts" "/etc/hosts"
}

symlink_dotfiles() {
  dotfiles="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

  # Link `bin/` directory
  # It's a `.bin` because I don't like seeing it
  link "$dotfiles/bin" "$HOME/.bin"

  # Link dotfiles
  for location in $(find home -name '*.sh'); do
    file="${location##*/}"
    file="${file%.sh}"
    link "$dotfiles/$location" "$HOME/.$file"
  done

  # Vim config
  link "$dotfiles/vim" "$HOME/.vim"
  touch "$HOME/.vimlocal"
}
