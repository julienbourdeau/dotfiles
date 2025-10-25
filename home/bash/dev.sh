############################################################
# Functions dedicated to dev env and workflow
############################################################


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
