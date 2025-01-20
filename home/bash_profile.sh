
#########################
#  Load vars from .env
#########################

# Export variables from ~/.env to the environment
if [ -f "$HOME/.env" ]; then
  for envvar in $(egrep -v '^#' $HOME/.env | xargs -n1); do
    export "$envvar";
  done;
fi;

#########################
#  General Config
#########################

source "$HOME/.bash/helpers.sh"

load_file "$HOME/.bash/vars.sh"
load_file "$HOME/.bash/path.sh"
load_file "$HOME/.bash/aliases.sh"
load_file "$HOME/.bash/functions.sh"
load_file "$HOME/.bash/bash_prompt.sh"
load_file "$HOME/.bash/dev.sh"
load_file "$HOME/.bash/extra.sh"

# Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob;

# Append to the Bash history file, rather than overwriting it
shopt -s histappend;

# Autocorrect typos in path names when using `cd`
shopt -s cdspell;

# Enable some Bash 4 features when possible:
# * `autocd`, e.g. `**/qux` will enter `./foo/bar/baz/qux`
# * Recursive globbing, e.g. `echo **/*.txt`
for option in autocd globstar; do
  shopt -s "$option" 2> /dev/null;
done;


#########################
#  Autocompletion
#########################

load_file "/etc/bash_completion";

if which brew &> /dev/null; then
  load_all_files "$(brew --prefix)/etc/bash_completion.d/*"
fi;

load_all_files "$HOME/.bash/bash_completion.d/*"

# Add tab completion for SSH hostnames based on ~/.ssh/config, ignoring wildcards
[ -e "$HOME/.ssh/config" ] && complete -o "default" -o "nospace" -W "$(grep "^Host" ~/.ssh/config | grep -v "[?*]" | cut -d " " -f2- | tr ' ' '\n')" scp sftp ssh;

# Add tab completion for `defaults read|write NSGlobalDomain`
# You could just use `-g` instead, but I like being explicit
complete -W "NSGlobalDomain" defaults;

# Add `killall` tab completion for common apps
complete -o "nospace" -W "Contacts Calendar Dock Finder Mail Safari iTunes SystemUIServer Terminal Twitter" killall;



#########################
#  Load utilities
#########################

if which rbenv &> /dev/null; then
  eval "$(rbenv init -)"
fi;

load_file "$HOME/.fzf.bash"

if which brew &> /dev/null; then
  load_file "$(brew --prefix)/opt/nvm/nvm.sh"
  load_all_files "$(brew --prefix)/etc/profile.d/*.sh"
  eval "$(zoxide init bash)"
fi;


# Herd injected NVM configuration
# export NVM_DIR="/Users/julien/Library/Application Support/Herd/config/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm


# Herd injected PHP 8.3 configuration.
export HERD_PHP_83_INI_SCAN_DIR="/Users/julien/Library/Application Support/Herd/config/php/83/"


# Herd injected PHP binary.
export PATH="/Users/julien/Library/Application Support/Herd/bin/":$PATH
