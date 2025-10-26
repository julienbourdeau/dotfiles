#########################
#  Load vars from .env
#########################

# Increase Bash history size. Allow 32³ entries; the default is 500.
export HISTSIZE='32768'
export HISTFILESIZE="${HISTSIZE}"
# Omit duplicates and commands that begin with a space from history.
export HISTCONTROL='ignoreboth'

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

# Highlight section titles in manual pages.
export LESS_TERMCAP_md="${yellow}"

# Don’t clear the screen after quitting a manual page.
export MANPAGER='less -X'


# Set up bat config: https://github.com/sharkdp/bat#configuration-file
export BAT_THEME=GitHub

export USE_GKE_GCLOUD_AUTH_PLUGIN=True

export SSH_AUTH_SOCK=~/.1password/agent.sock


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

function load_file() {
	[ -r "$1" ] && [ -f "$1" ] && source "$1"
}

function load_all_files() {
	for file in $1; do
		[ -r "$file" ] && [ -f "$file" ] && source "$file"
	done
}


export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:$PATH"
export PATH="$HOME/.composer/vendor/bin:$PATH"
export PATH="$PATH:$HOME/.bin:$HOME/bin"

# Use GNU utils
export PATH="/opt/homebrew/opt/coreutils/libexec/gnubin:$PATH"
export PATH="/opt/homebrew/opt/findutils/libexec/gnubin:$PATH"
export PATH="/opt/homebrew/opt/gnu-sed/libexec/gnubin:$PATH"


load_file "$HOME/.bash/aliases.sh"
load_file "$HOME/.bash/bash_prompt.sh"

# Mise-en-place
eval "$(mise activate bash)"


# Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob

# Append to the Bash history file, rather than overwriting it
shopt -s histappend

# Autocorrect typos in path names when using `cd`
shopt -s cdspell

# Enable some Bash 4 features when possible:
# * `autocd`, e.g. `**/qux` will enter `./foo/bar/baz/qux`
# * Recursive globbing, e.g. `echo **/*.txt`
for option in autocd globstar; do
	shopt -s "$option" 2>/dev/null
done


#  Autocompletion
load_file "/etc/bash_completion"
if which brew &>/dev/null; then
	load_all_files "$(brew --prefix)/etc/bash_completion.d/*"
fi
load_all_files "$HOME/.bash/bash_completion.d/*"

# Add tab completion for SSH hostnames based on ~/.ssh/config, ignoring wildcards
[ -e "$HOME/.ssh/config" ] && complete -o "default" -o "nospace" -W "$(grep "^Host" ~/.ssh/config | grep -v "[?*]" | cut -d " " -f2- | tr ' ' '\n')" scp sftp ssh

# Add tab completion for `defaults read|write NSGlobalDomain`
# You could just use `-g` instead, but I like being explicit
complete -W "NSGlobalDomain" defaults


# Herd injected PHP binary.
export PATH="/Users/julien/Library/Application Support/Herd/bin/":$PATH


# Herd injected PHP 8.4 configuration.
export HERD_PHP_84_INI_SCAN_DIR="/Users/julien/Library/Application Support/Herd/config/php/84/"


# Herd injected PHP 8.3 configuration.
export HERD_PHP_83_INI_SCAN_DIR="/Users/julien/Library/Application Support/Herd/config/php/83/"
