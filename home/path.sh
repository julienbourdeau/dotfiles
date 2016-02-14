# Homebrew bin directories
export PATH="~/.bin:/usr/local/bin:/usr/local/sbin:$PATH";

# Use GNU utils
PATH="/usr/local/opt/findutils/libexec/gnubin:$PATH"
PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"


###############
#   MANPATH   #
###############

# Manpages for GNU utils
MANPATH="/usr/local/opt/findutils/libexec/gnuman:$MANPATH"
MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"
