# Make vim the default editor.
export EDITOR='vim';

# Increase Bash history size. Allow 32³ entries; the default is 500.
export HISTSIZE='32768';
export HISTFILESIZE="${HISTSIZE}";
# Omit duplicates and commands that begin with a space from history.
export HISTCONTROL='ignoreboth';

# Prefer US English and use UTF-8.
export LANG='en_US.UTF-8';
export LC_ALL='en_US.UTF-8';

# Highlight section titles in manual pages.
export LESS_TERMCAP_md="${yellow}";

# Don’t clear the screen after quitting a manual page.
export MANPAGER='less -X';

#### EASY COLORS ###
export bold='';
export reset="\e[0m";
export black="\e[1;30m";
export red="\e[31m";
export green="\e[32m";
export yellow="\e[1;33m";
export blue="\e[1;34m";
export purple="\e[1;35m";
export cyan="\e[36m";
export white="\e[1;37m";

# export helper functions for scripts
export -f e_header e_arrow e_success e_error e_warning e_note
