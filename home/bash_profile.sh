######################### 
#  General Config
######################### 

# Load the shell dotfiles, and then some:
# * ~/.path can be used to extend `$PATH`.
# * ~/.extra can be used for other settings you don’t want to commit.
for file in ~/.bash/{path,vars,aliases,functions,helpers,bash_prompt,extra}.sh; do
	[ -r "$file" ] && [ -f "$file" ] && source "$file";
done;
unset file;

# Export variables from ~/.env to the environment
if [ -f "$HOME/.env" ]; then
  export $(egrep -v '^#' $HOME/.env | xargs)
fi;

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

if [ -f /etc/bash_completion ]; then
	source /etc/bash_completion;
fi;

if which brew &> /dev/null; then
	for file in $(brew --prefix)/etc/bash_completion.d/*;
	  do [ -r "$file" ] && [ -f "$file" ] && source "$file";
	done
fi;

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

files=(
	"$HOME/.rvm/scripts/rvm"
	"~/.fzf.bash"
)
for file in $files; do
	[ -r "$file" ] && [ -f "$file" ] && source "$file";
done;

# Only if there is homebrew (so every macos computer)
if which brew &> /dev/null; then
	files=(
		"$(brew --prefix)/opt/nvm/nvm.sh"
	)
	for file in $files; do
		[ -r "$file" ] && [ -f "$file" ] && source "$file";
	done;

	for file in $(brew --prefix)/etc/profile.d/*.sh;
	  do [ -r "$file" ] && [ -f "$file" ] && source "$file";
	done
fi;

unset files;
unset file;