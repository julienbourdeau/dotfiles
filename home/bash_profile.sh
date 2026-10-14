# shellcheck shell=bash
#########################
#  Bash config
#########################
# Fish is the interactive shell, but bash is the login shell and what agents
# use. Keep this file in sync with config/fish/config.fish. Anything both
# shells can parse lives in ~/.shell/ (home/shell/) and is sourced by both.

function load_file() {
	[ -r "$1" ] && [ -f "$1" ] && source "$1"
}

# Export variables from ~/.env (KEY=value lines, not versioned)
if [ -f "$HOME/.env" ]; then
	set -a
	source "$HOME/.env"
	set +a
fi

load_file "$HOME/.shell/env.sh"


#########################
#  PATH
#########################

# Mirror of `fish_add_path`: prepend a dir unless it's missing or already in PATH.
# Keep the list below in sync with config/fish/config.fish so both shells get the same PATH.
function path_add() {
	[ -d "$1" ] || return 0
	case ":$PATH:" in
		*":$1:"*) ;;
		*) export PATH="$1:$PATH" ;;
	esac
}

eval "$(/opt/homebrew/bin/brew shellenv)"

path_add "/usr/local/bin"
path_add "$HOME/Library/Application Support/Herd/bin"
path_add "$HOME/.composer/vendor/bin"
path_add "$HOME/.cargo/bin"

# Use GNU utils
path_add "$HOMEBREW_PREFIX/opt/coreutils/libexec/gnubin"
path_add "$HOMEBREW_PREFIX/opt/gnu-sed/libexec/gnubin"
path_add "$HOMEBREW_PREFIX/opt/findutils/libexec/gnubin"

path_add "$HOME/.local/bin"
path_add "$HOME/.bin"

# Mise-en-place: shims for every shell (agents, scripts), full activation
# (PROMPT_COMMAND hook) only when interactive. Same as config.fish.
if [[ $- == *i* ]]; then
	eval "$(mise activate bash)"
else
	eval "$(mise activate bash --shims)"
fi

# Ensure ruby always load my personal config
if [ -f "$HOME/.ruby/boot.rb" ]; then
	export RUBYOPT="-I$HOME/.ruby/ -r boot"
fi

load_file "$HOME/.shell/aliases.sh"

# Recursive globbing, e.g. `echo **/*.txt`
shopt -s globstar


#########################
#  Interactive only
#########################
# Agents run non-interactive shells, so they skip this block.

if [[ $- == *i* ]]; then
	if command -v bat >/dev/null 2>&1; then
		alias cat=bat
	fi

	# `tree` with hidden files and color enabled, ignoring
	# the `.git` directory, listing directories first.
	alias tree="tree -aC -I '.git|.idea|vendor|node_modules' --dirsfirst"

	#### EASY COLORS ###
	export reset="\e[0m"
	export black="\e[1;30m"
	export red="\e[31m"
	export green="\e[32m"
	export yellow="\e[1;33m"
	export blue="\e[1;34m"
	export purple="\e[1;35m"
	export cyan="\e[36m"
	export white="\e[1;37m"

	# Highlight section titles in manual pages.
	export LESS_TERMCAP_md="${yellow}"

	load_file "$HOME/.bash/bash_prompt.sh"
fi
