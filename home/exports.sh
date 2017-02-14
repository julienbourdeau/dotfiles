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
if tput setaf 1 &> /dev/null; then
  tput sgr0; # reset colors
  export c_bold=$(tput bold);
  export c_underline=$(tput sgr 0 1)
  export c_reset=$(tput sgr0);
  # Solarized colors, taken from http://git.io/solarized-colors.
  export c_black=$(tput setaf 0);
  export c_blue=$(tput setaf 33);
  export c_cyan=$(tput setaf 37);
  export c_green=$(tput setaf 64);
  export c_orange=$(tput setaf 166);
  export c_purple=$(tput setaf 125);
  export c_red=$(tput setaf 124);
  export c_violet=$(tput setaf 61);
  export c_white=$(tput setaf 15);
  export c_yellow=$(tput setaf 136);
else
  export c_bold='';
  export c_underline='';
  export c_reset="\e[0m";
  export c_black="\e[1;30m";
  export c_blue="\e[1;34m";
  export c_cyan="\e[1;36m";
  export c_green="\e[1;32m";
  export c_orange="\e[1;33m";
  export c_purple="\e[1;35m";
  export c_red="\e[1;31m";
  export c_violet="\e[1;35m";
  export c_white="\e[1;37m";
  export c_yellow="\e[1;33m";
fi;

# export helper functions for scripts
export -f e_header e_arrow e_success e_error e_warning e_underline e_bold e_note
