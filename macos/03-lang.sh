#!/usr/bin/env bash

source "./00-brew.sh"

e_title "Installing Database systems"

e_arrow "Installing sqlite"
brew install sqlite
e_arrow "Installing redis"
brew install redis
e_arrow "Installing postgresql"
brew install postgresql
e_arrow "Installing mysql"
brew install mysql

e_title "Installing Ruby ecosystem..."

brew install rbenv ruby-build
ruby_update 3.4.1

e_title "Installing PHP ecosystem... with Laravel Herd"

brew install --cask herd

e_title "Installing Node.js ecosystem"

brew install nvm
node_upgrade 23
