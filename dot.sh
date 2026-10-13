#!/usr/bin/env bash

set -euo pipefail

dotfiles="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DRY_RUN=0

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

e_header() {
	printf "\n\n${yellow}==========  %s  ==========${reset}\n" "$@"
}
e_arrow() {
	printf "➜ %b\n" "$@"
}
e_success() {
	printf "${green}✔ %b${reset}\n" "$@"
}
e_error() {
	printf "${red}✖ %b${reset}\n" "$@"
}
e_warning() {
	printf "${yellow}➜ %b${reset}\n" "$@"
}
e_note() {
	printf "${blue}Note: %b${reset}\n" "$@"
}

# Execute a command, or just skip it in dry-run mode. The caller is
# responsible for announcing intent (via e_arrow/e_header).
run() {
	if [[ "$DRY_RUN" -eq 1 ]]; then
		return 0
	fi
	"$@"
}

symlink() {
	local from="$1"
	local to="$2"
	if [[ "$DRY_RUN" -eq 1 ]]; then
		e_arrow "[dry-run] would link '$from' → '$to'"
	else
		e_arrow "Linking '$from' to '$to'"
	fi
	run rm -f "$to"
	run ln -s "$from" "$to"
}

susymlink() {
	local from="$1"
	local to="$2"
	if [[ "$DRY_RUN" -eq 1 ]]; then
		e_arrow "[dry-run] would sudo-link '$from' → '$to'"
	else
		e_arrow "Linking '$from' to '$to'"
	fi
	run sudo rm -f "$to"
	run sudo ln -s "$from" "$to"
}

link_mise() {
	e_header "Symlinking mise global config"
	symlink "$dotfiles/etc/mise.global.toml" "$HOME/.config/mise/config.toml"
}

link_fish() {
	e_header "Symlinking fish config"
	local config_root="$HOME/.config/fish"
	find config/fish -type f -printf '%P\n' | while read -r relpath; do
		local dest_dir
		dest_dir="$config_root/$(dirname "$relpath")"
		if [[ ! -d "$dest_dir" ]]; then
			run mkdir -p "$dest_dir"
		fi
		symlink "$dotfiles/config/fish/$relpath" "$config_root/$relpath"
	done
}

# Symlink the home/ tree into $HOME:
#   - dirs:  ./home/<name>       → ~/.<name>
#   - files: ./home/<name>.sh    → ~/.<name>
#            ./home/conf.<name>  → ~/.<name>
# The conf.<name> convention keeps the source file unhidden so editors
# recognize it (e.g. conf.vimrc is edited as .vimrc).
link_home() {
	e_header "Symlinking home/ into \$HOME"

	find home -mindepth 1 -maxdepth 1 -type d | while read -r location; do
		local file="${location##*/}"
		symlink "$dotfiles/$location" "$HOME/.$file"
	done

	find home -maxdepth 1 -not -type d | while read -r location; do
		local file="${location##*/}"
		file="${file#conf.}"
		file="${file%.sh}"
		symlink "$dotfiles/$location" "$HOME/.$file"
	done
}

# Files kept in etc/ with canonical names so editors get syntax highlighting
# (e.g. Brewfile for Ruby DSL, irbrc.rb for Ruby).
link_etc() {
	e_header "Symlinking files from etc/ into \$HOME"
	symlink "$dotfiles/etc/Brewfile" "$HOME/.Brewfile"
	symlink "$dotfiles/etc/irbrc.rb" "$HOME/.irbrc"
	symlink "$dotfiles/etc/claude.json" "$HOME/.claude-work/settings.json"
	symlink "$dotfiles/etc/claude.json" "$HOME/.claude-personal/settings.json"
	symlink "$dotfiles/etc/CLAUDE.md" "$HOME/.claude/CLAUDE.md"
}

link_vim() {
	e_header "Symlinking VIM config"
	symlink "$dotfiles/vim" "$HOME/.vim"
	run touch "$HOME/.vimlocal"
}

setup_env() {
	e_header "Creating ~/.env file"
	if [[ ! -f "$HOME/.env" ]]; then
		e_arrow "Copying '$dotfiles/etc/env.example' to '$HOME/.env'"
		# shellcheck disable=SC2088
		e_warning "~/.env is currently empty, add the necessary values"
		run cp "$dotfiles/etc/env.example" "$HOME/.env"
	else
		# shellcheck disable=SC2088
		e_note "~/.env already exists"
	fi
}

symlink_dotfiles() {
	link_mise
	link_fish
	link_home
	link_etc
	link_vim
	setup_env
}

macos_defaults() {
	local sub="$1"
	e_header "macOS defaults: $sub"
	if [[ "$DRY_RUN" -eq 1 ]]; then
		e_arrow "[dry-run] would run 'macos/defaults.sh $sub'"
		return 0
	fi
	bash "$dotfiles/macos/defaults.sh" "$sub"
}

install_brew() {
	e_header "Homebrew bundle"

	if ! command -v brew >/dev/null 2>&1; then
		e_arrow "Installing Homebrew"
		if [[ "$DRY_RUN" -eq 1 ]]; then
			e_arrow "[dry-run] would install Homebrew"
		else
			/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
		fi
	else
		e_note "Homebrew already installed"
	fi

	symlink "$dotfiles/etc/Brewfile" "$HOME/.Brewfile"

	e_arrow "Running 'brew bundle install --global'"
	run brew bundle install --global
}

symlink_sublime() {
	e_header "Symlinking Sublime Text config"

	symlink "$dotfiles/macos/Preferences.sublime-settings" "$HOME/Library/Application Support/Sublime Text/Packages/User/Preferences.sublime-settings"

	e_note "Make sure you install the theme https://github.com/mauroreisvieira/github-sublime-theme"
}

######################################################
##    USAGE
######################################################

usage() {
	echo "Usage:" >&2
	echo "$0 [--dry-run] [--dotfiles] [--brew] [--sublime] [--macos|--macos-export|--macos-diff] [--hostname <name>]" >&2
	echo "" >&2
	echo "Options:" >&2
	echo "   -d | --dotfiles    Symlink dotfiles in home/ directory" >&2
	echo "   --brew             Install Homebrew, symlink Brewfile, run 'brew bundle install --global'" >&2
	echo "   --sublime          Symlink Sublime Text preferences" >&2
	echo "   --macos            Apply macOS defaults from macos/defaults.yaml" >&2
	echo "   --macos-export     Read current system values, rewrite macos/defaults.yaml" >&2
	echo "   --macos-diff       Show keys where the manifest and system disagree" >&2
	echo "   --hostname <name>  Set ComputerName, LocalHostName, and HostName (requires sudo)" >&2
	echo "   -n | --dry-run     Print what would be linked without touching the filesystem" >&2
}

set_hostname() {
	local name="$1"

	# LocalHostName must be RFC 1123-ish: letters, digits, hyphens; ≤64 chars.
	# mDNS resolvers will reject anything else, so fail fast before sudo.
	if [[ -z "$name" ]]; then
		e_error "--hostname: empty value"
		return 1
	fi
	if [[ ! "$name" =~ ^[A-Za-z0-9-]+$ ]]; then
		e_error "--hostname: '$name' contains characters outside [A-Za-z0-9-]"
		return 1
	fi
	if (( ${#name} > 64 )); then
		e_error "--hostname: '$name' is ${#name} chars; LocalHostName max is 64"
		return 1
	fi

	e_header "Setting hostname to '$name'"

	# ComputerName is the friendly name shown in Finder; any UTF-8 is fine,
	# so we pass the value through verbatim. LocalHostName is the
	# Bonjour/mDNS name and must match the sanitized value.
	if [[ "$DRY_RUN" -eq 1 ]]; then
		e_arrow "[dry-run] would run: sudo scutil --set ComputerName $name"
		e_arrow "[dry-run] would run: sudo scutil --set LocalHostName $name"
		e_arrow "[dry-run] would run: sudo scutil --set HostName $name"
		return 0
	fi

	run sudo scutil --set ComputerName "$name"
	run sudo scutil --set LocalHostName "$name"
	run sudo scutil --set HostName "$name"
	e_success "Hostname set (restart applications to see ComputerName in menus)"
}

######################################################
##    PARAMETERS
######################################################

if [[ $# -eq 0 ]]; then
	usage
	exit 100
fi

# First pass: pick up flags that modify behavior of later actions.
for i in "$@"; do
	case $i in
	-n | --dry-run)
		DRY_RUN=1
		;;
	esac
done

if [[ "$DRY_RUN" -eq 1 ]]; then
	e_note "Dry-run mode: no changes will be made"
fi

# Second pass: dispatch actions. Index-based so flags that take an argument
# (e.g. --hostname <name>) can consume the next slot. We materialize "$@"
# into an array first to avoid indirect expansion (${!i} would also pick
# up $0 at i=0).
args=("$@")
i=0
while [[ $i -lt $# ]]; do
	arg="${args[$i]}"
	case $arg in
	-n | --dry-run)
		;;
	-d | --dotfiles)
		symlink_dotfiles
		;;
	--brew)
		install_brew
		;;
	--sublime)
		symlink_sublime
		;;
	--macos)
		macos_defaults apply
		;;
	--macos-export)
		macos_defaults export
		;;
	--macos-diff)
		macos_defaults diff
		;;
	--hostname)
		next=$((i + 1))
		if [[ $next -ge $# ]]; then
			e_error "--hostname requires a value"
			exit 100
		fi
		set_hostname "${args[$next]}"
		i=$next
		;;
	*)
		usage
		exit 100
		;;
	esac
	i=$((i + 1))
done
