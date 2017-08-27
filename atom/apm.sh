#!/usr/bin/env bash

# Update package
apm update

e_header "Install themes"

apm install atom-material-ui atom-material-syntax
e_note "Remember to update settings"

e_header "Install must-have packages"

apm install \
  minimap \
  emmet \
  editorconfig \
  highlight-bad-chars \
  advanced-open-file

e_header "Install syntax packages"

apm install \
  ssh-config \
  language-twig \
  language-blade \
  language-nginx \
  language-apache \
  language-ignore

e_header "Install linters"

apm install \
  linter \
  linter-php \
  linter-shellcheck
