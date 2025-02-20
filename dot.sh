#!/usr/bin/env bash

######################################################
##    FUNCTIONS
######################################################

switch_to_homebrew_bash() {
	if ! fgrep -q '/opt/homebrew/bin/bash' /etc/shells; then
		echo '/opt/homebrew/bin/bash' | sudo tee -a /etc/shells
		chsh -s /opt/homebrew/bin/bash
		e_note "Now using bash from Homebrew"
	fi
}

symlink() {
	from="$1"
	to="$2"
	e_arrow "Linking '$from' to '$to'"
	rm -f "$to"
	ln -s "$from" "$to"
}

susymlink() {
	from="$1"
	to="$2"
	e_arrow "Linking '$from' to '$to'"
	sudo rm -f "$to"
	sudo ln -s "$from" "$to"
}

symlink_host_file() {
	e_header "Linking hosts file"

	if [ ! -L "/etc/hosts" ]; then
		e_arrow "Saving original file to /etc/hosts.orig"
		sudo cp -f /etc/hosts /etc/hosts.orig
	fi

	dotfiles="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

	if [ ! -f "$dotfiles/etc/hosts.local" ]; then
		cp "$dotfiles/etc/hosts" "$dotfiles/etc/hosts.local"
	fi

	susymlink "$dotfiles/etc/hosts.local" "/etc/hosts"
}

symlink_dotfiles() {
	dotfiles="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

	# Link dotfiles
	e_header "Symlinking dotfiles"

	# Symlink dirs from ./home/folders to ~/.folder
	find home -mindepth 1 -type d | while read -r location; do
		file="${location##*/}"
		symlink "$dotfiles/$location" "$HOME/.$file"
	done

	# Symlink files
	# from ./home/config.sh to ~/.config
	# from ./home/conf.apprc to ~/.apprc
	# from ./home/config.ext to ~/.config.ext
	# Example:
	# 	.vimrc becomes conf.vimrc so 1. it's not hidden 2. editor know it's .vimrc file
	find home -maxdepth 1 -not -type d | while read -r location; do
		file="${location##*/}"
		file="${file#conf.}"
		file="${file%.sh}"
		symlink "$dotfiles/$location" "$HOME/.$file"
	done

	# Vim config
	e_header "Symlinking VIM config"
	symlink "$dotfiles/vim" "$HOME/.vim"
	touch "$HOME/.vimlocal"

	# .env
	e_header "Creating ~/.env file"
	if [ ! -f "$HOME/.env" ]; then
		e_arrow "Copying '$dotfiles/etc/env.example' to '$HOME/.env'"
		e_warning "~/.env is currently empty, add the necessary values"
		cp "$dotfiles/etc/env.example" "$HOME/.env"
	else
		e_note "~/.env already exists"
	fi
}

symlink_sublime() {
	dotfiles="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

	e_header "Symlinking Sublime Text config"

	symlink "$dotfiles/macos/Preferences.sublime-settings" "$HOME/Library/Application Support/Sublime Text/Packages/User/Preferences.sublime-settings"

	e_note "Make sure you install the theme https://github.com/mauroreisvieira/github-sublime-theme"
}

setup_php() {
	if ! command -v herd &>/dev/null; then
		e_error "Laravel Herd not found. Ensure it is installed and available in the PATH."
		exit 1
	fi

	dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/home/php"
	(cd $dir && composer install)

	echo
	tree "$(dirname "$(command -v herd)")/../config/php"

	echo
	e_note "Add the following line to your php.ini configuration"
	echo
	echo "  auto_prepend_file = $dir/prepend.php"
	echo
	e_note "Or add this line to your favorite script"
	echo
	echo "require_once '$dir/vendor/autoload.php';"
}

######################################################
##    USAGE
######################################################

usage() {
	echo "Usage:" >&2
	echo "$0 [--dotfiles] [--sublime] [--hosts] [--homebrew-bash] [--php]" >&2
	echo "" >&2
	echo "Options:" >&2
	echo "   -d | --dotfiles    Symlink dotfiles in home/ directory" >&2
	echo "   -h | --hosts       Create local hosts files and symlink it" >&2
	echo "   --php              Setup php prepended file" >&2
	echo "   --sublime          Symlink Sublime Text preferences" >&2
	echo "   --homebrew-bash    Add bash from homebrew to shell login and switch to it" >&2
}

######################################################
##    PARAMETERS
######################################################

if [ $# -eq 0 ]; then
	usage
	exit 100
fi

for i in "$@"; do
	case $i in
	-d | --dotfiles)
		symlink_dotfiles
		;;
	--sublime)
		symlink_sublime
		;;
	--php)
		setup_php
		;;
	-h | --hosts)
		symlink_host_file
		;;
	--homebrew-bash)
		switch_to_homebrew_bash
		;;
	*)
		usage
		exit 100
		;;
	esac
done
