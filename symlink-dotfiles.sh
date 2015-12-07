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

sulink() {
  from="$1"
  to="$2"
  echo "Linking '$from' to '$to'"
  sudo rm -f "$to"
  sudo ln -s "$from" "$to"
}

# Link `bin/` directory
# It's a `.bin` because I don't like seeing it
link "$dotfiles/bin" "$HOME/.bin"

# Link dotfiles
for location in $(find home -name '*.sh'); do
  file="${location##*/}"
  file="${file%.sh}"
  link "$dotfiles/$location" "$HOME/.$file"
done

# Link apache conf
if [[ `uname` == 'Darwin' ]]; then
  echo "Linking Apache config"
  # httpd.conf
  sudo rm "/etc/apache2/httpd.conf.bk"
  sudo mv "/etc/apache2/httpd.conf" "/etc/apache2/httpd.conf.bk"
  sulink "$dotfiles/etc/apache2/httpd.conf" "/etc/apache2/httpd.conf"

  # extra/ folder
  for location in $(find etc/apache2/extra -name '*.conf'); do
    file="${location##*/}"
    file="${file}"
    sulink "$dotfiles/$location" "/etc/apache2/extra/$file"
  done

  # users/ folder
  for location in $(find etc/apache2/users -name '*.conf'); do
    file="${location##*/}"
    file="${file}"
    sulink "$dotfiles/$location" "/etc/apache2/users/$file"
  done
fi


# Sublime
if [[ `uname` == 'Darwin' ]]; then
  link "$dotfiles/sublime/Packages/User/Preferences.sublime-settings" "$HOME/Library/Application Support/Sublime Text 3/Packages/User/Preferences.sublime-settings"
  link "$dotfiles/sublime/Packages/User/Package Control.sublime-settings" "$HOME/Library/Application Support/Sublime Text 3/Packages/User/Package Control.sublime-settings"
  sudo cp "$dotfiles/sublime/Sublime Text.icns" "/Applications/Sublime Text.app/Contents/Resources/Sublime Text.icns"
  link "/Applications/Sublime Text.app/Contents/SharedSupport/bin/subl" "/usr/local/bin/subl"
fi

# Vim config
link "$dotfiles/vim" "$HOME/.vim"
touch "$HOME/.vimlocal"

# Host file
sudo rm -f /etc/hosts
sulink "$dotfiles/etc/hosts" "/etc/hosts"
