#!/bin/bash

dotfiles="$HOME/Projects/dotfiles"

if [[ -d "$dotfiles" ]]; then
  echo "Symlinking dotfiles from $dotfiles"
else
  echo "$dotfiles does not exist"
  exit 1
fi

link() {
  from="$1"
  to="$2"
  echo "Linking '$from' to '$to'"
  rm -f "$to"
  ln -s "$from" "$to"
}

# Link dotfiles
for location in $(find home -name '*.sh'); do
  file="${location##*/}"
  file="${file%.sh}"
  link "$dotfiles/$location" "$HOME/.$file"
done

# Sublime
if [[ `uname` == 'Darwin' ]]; then
  link "$dotfiles/sublime/Packages/User/Preferences.sublime-settings" "$HOME/Library/Application Support/Sublime Text 3/Packages/User/Preferences.sublime-settings"
  link "$dotfiles/sublime/Packages/User/Package Control.sublime-settings" "$HOME/Library/Application Support/Sublime Text 3/Packages/User/Package Control.sublime-settings"
fi

# Vim config
link "$dotfiles/vim" "$HOME/.vim"
touch "$HOME/.vimlocal"

# Host file
sudo link $dotfiles/etc/hosts /etc/hosts


