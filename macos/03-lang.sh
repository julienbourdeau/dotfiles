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


e_title "Installing PHP ecosystem... with Laravel Herd"

brew install --cask herd

e_title "Installing Node.js ecosystem"

brew install nvm
nvm install node
npm install -g yarn eslint doctoc prettier


echo
nvm list
echo


