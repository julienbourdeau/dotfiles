function laravel_after_clone() {
  e_header "Setting up new clone"

  if [[ ! -f ".env" ]]
  then
    e_arrow "Coping .env.example to .env"
    cp .env.example .env
  else
    e_note ".env file already exists"
  fi

  echo
  e_arrow "Setting up new APP_KEY"
  art key:generate

  echo
  e_arrow "Installing PHP dependencies"
  composer install

  echo
  e_arrow "Installing frontend dependencies"
  if [[ -f "yarn.lock" ]]
  then
    yarn install
  else
    npm install
  fi

  echo
  db_name=$(awk -F"[=]+" '/DB_DATABASE/{print $2}' .env)
  e_arrow "Creating database ($db_name)"
  mysql --user=root --password=$DB_PASSWORD -e "CREATE DATABASE $db_name;"

  echo
  e_arrow "Migrating data"
  art migrate:fresh --seed

  echo
  e_success "DONE"
}
