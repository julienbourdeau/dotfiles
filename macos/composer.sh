#!/usr/bin/env bash

composer global require laravel/valet
composer global require psy/psysh
composer global require friendsofphp/php-cs-fixer
composer global require laravel/installer


valet install
# valet tld test
valet trust