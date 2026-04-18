#!/usr/bin/env bash

######################################################
##    FUNCTIONS
######################################################

export bold=''
export reset="\e[0m"
export black="\e[1;30m"
export red="\e[31m"
export green="\e[32m"
export yellow="\e[1;33m"
export blue="\e[1;34m"
export purple="\e[1;35m"
export cyan="\e[36m"
export white="\e[1;37m"

function e_header() {
	printf "\n\n${yellow}==========  %s  ==========${reset}\n" "$@"
}
function e_arrow() {
	printf "➜ %b\n" "$@"
}
function e_success() {
	printf "${green}✔ %b${reset}\n" "$@"
}
function e_error() {
	printf "${red}✖ %b${reset}\n" "$@"
}
function e_warning() {
	printf "${yellow}➜ %b${reset}\n" "$@"
}
function e_note() {
	printf "${blue}Note: %b${reset}\n" "$@"
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


symlink_dotfiles() {
	dotfiles="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

	# Link dotfiles
	e_header "Symlinking dotfiles"

	# Symlink mise global config
	symlink "$dotfiles/config/mise/mise.global.toml" "$HOME/.config/mise/config.toml"
	echo

	# Symlink .config/fish files
	find config/fish -type f -printf '%P\n' | while read -r relpath; do
    	config_root="$HOME/.config/fish"
    	dest_dir="$config_root/$(dirname "$relpath")"
    	if [ ! -d $dest_dir ]; then
          mkdir -p $dest_dir
        fi
        symlink "$dotfiles/config/fish/$relpath" "$config_root/$relpath"
    done

    echo

	# Symlink dirs from ./home/folders to ~/.folder
	find home -mindepth 1 -maxdepth 1 -type d | while read -r location; do
		file="${location##*/}"
		symlink "$dotfiles/$location" "$HOME/.$file"
	done

	echo

	# Symlink files
	#  - from ./home/config.sh to ~/.config
	#  - from ./home/conf.apprc to ~/.apprc
	#  - from ./home/config.ext to ~/.config.ext
	# Using conf.vimrc instead of .vimrc so 1. it's not hidden 2. editor recognize it's .vimrc file
	find home -maxdepth 1 -not -type d | while read -r location; do
		file="${location##*/}"
		file="${file#conf.}"
		file="${file%.sh}"
		symlink "$dotfiles/$location" "$HOME/.$file"
	done

	echo

	# Files in etc/ that need to be linked into $HOME
	# (kept in etc/ with canonical names so editors get syntax highlighting)
	e_header "Symlinking files from etc/ into \$HOME"
	symlink "$dotfiles/etc/Brewfile" "$HOME/.Brewfile"
	symlink "$dotfiles/etc/default-gems" "$HOME/.default-gems"
	symlink "$dotfiles/etc/irbrc.rb" "$HOME/.irbrc"

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

######################################################
##    USAGE
######################################################

usage() {
	echo "Usage:" >&2
	echo "$0 [--dotfiles] [--sublime]" >&2
	echo "" >&2
	echo "Options:" >&2
	echo "   -d | --dotfiles    Symlink dotfiles in home/ directory" >&2
	echo "   --sublime          Symlink Sublime Text preferences" >&2
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
	*)
		usage
		exit 100
		;;
	esac
done
