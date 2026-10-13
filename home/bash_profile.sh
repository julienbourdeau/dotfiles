#########################
#  Load vars from .env
#########################

# Export variables from ~/.env to the environment
if [ -f "$HOME/.env" ]; then
	for envvar in $(egrep -v '^#' $HOME/.env | xargs -n1); do
		export "$envvar"
	done
fi


#########################
#  General Config
#########################

# Make vim the default editor.
export EDITOR='vim'
export VISUAL='subl'


# Remove macos message about zsh being new default
export BASH_SILENCE_DEPRECATION_WARNING=1

# Prefer US English and use UTF-8.
export LANG='en_US.UTF-8'
export LC_ALL='en_US.UTF-8'

# Set up bat config: https://github.com/sharkdp/bat#configuration-file
export BAT_THEME=GitHub

export SSH_AUTH_SOCK=~/.1password/agent.sock

export HOMEBREW_NO_ENV_HINTS=1

# Ensure ruby always load my personal config
if [ -f "$HOME/.ruby/boot.rb" ]; then
	export RUBYOPT="-I$HOME/.ruby/ -r boot"
fi


function load_file() {
	[ -r "$1" ] && [ -f "$1" ] && source "$1"
}


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

path_add "$(brew --prefix)/bin"
path_add "$HOME/.bin"
path_add "$HOME/.local/bin"
path_add "/usr/local/bin"
path_add "$HOME/Library/Application Support/Herd/bin"
path_add "$HOME/.composer/vendor/bin"
path_add "$HOME/.cargo/bin"

# Use GNU utils
path_add "$(brew --prefix)/opt/coreutils/libexec/gnubin"
path_add "$(brew --prefix)/opt/gnu-sed/libexec/gnubin"
path_add "$(brew --prefix)/opt/findutils/libexec/gnubin"

# Herd's CLI php doesn't auto-load its ini, so point it at Herd's config.
# Bump the version number when the default Herd PHP changes (check with `php --ini`).
export HERD_PHP_85_INI_SCAN_DIR="$HOME/Library/Application Support/Herd/config/php/85/"


load_file "$HOME/.bash/aliases.sh"

# Mise-en-place
eval "$(mise activate bash)"

# Recursive globbing, e.g. `echo **/*.txt`
shopt -s globstar


#########################
#  Interactive only
#########################
# Agents run non-interactive shells, so they skip this block.

if [[ $- == *i* ]]; then
	#### EASY COLORS ###
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

	# Highlight section titles in manual pages.
	export LESS_TERMCAP_md="${yellow}"

	load_file "$HOME/.bash/bash_prompt.sh"
fi
