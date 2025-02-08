############################################################
# Functions dedicated to dev env and workflow
############################################################

function gclone() {
	git clone "$1" && cd "$(basename "$_" .git)"
	if [[ -f "artisan" ]]; then
		e_note 'Laravel was detected. Running _laravel_after_clone_ script'
		echo
		laravel_after_clone
	fi
	gs
}

# git rebase branch
function gupdate() {
	BRANCH_NAME=$1
	if [[ -z "$BRANCH_NAME" ]]; then
		e_error "Please provide a branch name. (ie: main or master)"
		return 1
	fi

	DIRTY=false
	if ! git diff-index --quiet HEAD --; then
		DIRTY=true
		e_note "Working directory has uncommitted changes"
	fi

	if $DIRTY; then
		git stash
	fi

	e_header "Update $BRANCH_NAME branch"
	git checkout $BRANCH_NAME
	git pull
	git checkout -

	e_header "Rebase on top of $BRANCH_NAME"
	git rebase $BRANCH_NAME

	if $DIRTY; then
		e_note "Restore stashed changes"
		git stash pop
	fi
	e_success "Updated"

	e_header "Current status"
	git status
	e_header "🌳 Tree"
	git lg -10
}

function gdeploy() {
	MAIN_BRANCH_NAME="master"
	STAGING_BRANCH_NAME="develop"

	if ! git diff-index --quiet HEAD --; then
		e_error "Cannot prepare release with dirty working directory"
		return 12
	fi

	e_header "Update $STAGING_BRANCH_NAME branch"
	git checkout $STAGING_BRANCH_NAME
	git pull

	e_header "Update $MAIN_BRANCH_NAME branch"
	git checkout $MAIN_BRANCH_NAME
	git pull

	e_header "Current status"
	git status
	e_header "🌳 Tree"
	git lg master..develop -100
}

function laravel_after_clone() {
	e_title "Setting up new clone"

	if [[ ! -f ".env" ]]; then
		e_header "Coping .env.example to .env"
		cp .env.example .env
		ll .env*
	else
		e_note ".env file already exists"
	fi

	e_header "Installing PHP dependencies"
	composer install

	e_header "Installing frontend dependencies"
	if [[ -f "yarn.lock" ]]; then
		yarn install
	else
		npm install
	fi

	e_header "Setting up new APP_KEY"
	art key:generate

	db_name=$(awk -F"[=]+" '/DB_DATABASE/{print $2}' .env)
	e_header "Creating database ($db_name)"
	mysql --user=root --password=$DB_PASSWORD -e "CREATE DATABASE $db_name;"

	e_header "Migrating data"
	art migrate:fresh --seed

	echo
	e_success "DONE"
}
