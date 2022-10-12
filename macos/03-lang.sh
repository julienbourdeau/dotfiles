#!/usr/bin/env bash

source "./00-brew.sh"

e_header "Installing Database systems"

e_arrow "Installing sqlite"
brew install sqlite
e_arrow "Installing redis"
brew install redis
e_arrow "Installing postgresql"
brew install postgresql
e_arrow "Installing mysql v5.7"
brew install mysql@5.7


e_header "Installing PHP ecosystem"

brew install php
brew install composer
brew install wp-cli

composer global require psy/psysh
composer global require friendsofphp/php-cs-fixer
composer global require laravel/installer

e_arrow "Installing Valet"

composer global require laravel/valet
valet install
valet tld laravel
valet trust


e_header "Installing Node.js ecosystem"

brew install nvm
npm install -g yarn eslint


e_header "Installing Go"

brew install go


e_header "Installing Ruby ecosystem"

gpg2 --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
\curl -sSL https://get.rvm.io | bash -s stable --rails

e_arrow "Also install latest 2.7"
rvm install 2.7
