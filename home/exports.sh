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
export c_bold=$(tput bold)
export c_underline=$(tput sgr 0 1)
export c_reset=$(tput sgr0)

export c_purple=$(tput setaf 171)
export c_red=$(tput setaf 1)
export c_green=$(tput setaf 76)
export c_tan=$(tput setaf 3)
export c_blue=$(tput setaf 38)

# export helper functions for scripts
export -f e_header e_arrow e_success e_error e_warning e_underline e_bold e_note
