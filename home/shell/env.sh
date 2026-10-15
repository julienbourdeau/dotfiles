# Environment shared by bash (~/.bash_profile) and fish (config.fish).
#
# Must stay parseable by BOTH shells: only `export NAME=value` lines and
# comments. No conditionals, no $(...), no arrays. Shell-specific logic
# belongs in bash_profile.sh or config.fish.

export EDITOR='vim'
export VISUAL='subl'
export LANG='en_US.UTF-8'
export LC_ALL='en_US.UTF-8'

export PAGER='bat'
export BAT_THEME='GitHub'

export SSH_AUTH_SOCK="$HOME/.1password/agent.sock"

export HOMEBREW_NO_ENV_HINTS=1
# Remove macOS message about zsh being the default shell
export BASH_SILENCE_DEPRECATION_WARNING=1

# Herd's CLI php doesn't auto-load its ini (scan path points at empty /usr/local/etc/php),
# so point it at Herd's config so custom values like memory_limit are honored.
# Bump the version number when the default Herd PHP changes (check with `php --ini`).
export HERD_PHP_85_INI_SCAN_DIR="$HOME/Library/Application Support/Herd/config/php/85/"

# Claude Code
export ENABLE_LSP_TOOL=1
