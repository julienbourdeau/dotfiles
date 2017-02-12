#!/usr/bin/env bash

source ./install-functions.sh

# Switch default bash to homebrew's bash
if [[ `uname` == 'Darwin' ]]; then
  read -p "Do you want to switch to '/usr/local/bin/bash'? " -n 1 -r
  echo    # move to a new line
  if [[ $REPLY =~ ^[Yy]$ ]]
  then
      switch_to_homebrew_bash
  fi
fi

# Symflink /etc/hosts
read -p "Do you want to replace /etc/hosts? " -n 1 -r
echo    # move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]
then
    symlink_host_file
fi

# Symlink config
symlink_dotfiles
