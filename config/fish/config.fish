# Fish is the interactive shell, but bash is the login shell and what agents
# use. Keep this file in sync with home/bash_profile.sh. Anything both shells
# can parse lives in ~/.shell/ (home/shell/) and is sourced by both.

# Export variables from ~/.env (KEY=value lines, not versioned)
if test -f "$HOME/.env"
    for line in (string match -rv '^\s*(#|$)' < $HOME/.env)
        set -l kv (string split -m1 '=' -- (string replace -r '^export\s+' '' -- $line))
        set -gx $kv[1] (string trim -c '"\'' -- $kv[2])
    end
end

source ~/.shell/env.sh

# == PATH
# Keep the list below in sync with home/bash_profile.sh so both shells get the same PATH.

eval "$(/opt/homebrew/bin/brew shellenv)"

fish_add_path -g /usr/local/bin
fish_add_path -g ~/Library/Application\ Support/Herd/bin
fish_add_path -g ~/.composer/vendor/bin
fish_add_path -g ~/.cargo/bin

# Use GNU utils
fish_add_path -g "$HOMEBREW_PREFIX/opt/coreutils/libexec/gnubin"
fish_add_path -g "$HOMEBREW_PREFIX/opt/gnu-sed/libexec/gnubin"
fish_add_path -g "$HOMEBREW_PREFIX/opt/findutils/libexec/gnubin"

fish_add_path -g ~/.local/bin
fish_add_path -g ~/.bin

# Mise-en-place: shims for every shell, full activation only when interactive.
if status is-interactive
    mise activate fish | source
else
    mise activate fish --shims | source
end

# Ensure ruby always load my personal config
if test -f "$HOME/.ruby/boot.rb"
    set -gx RUBYOPT "-I$HOME/.ruby/ -r boot"
end

source ~/.shell/aliases.sh

if status is-interactive
    if command -q bat
        alias cat=bat
    end

    # `tree` with hidden files and color enabled, ignoring
    # the `.git` directory, listing directories first.
    alias tree="tree -aC -I '.git|.idea|vendor|node_modules' --dirsfirst"

    # Smarter cd: `z foo`, `zi` for interactive picking
    command -q zoxide; and zoxide init fish | source
    alias j='z'

    set -gx tide_git_color_branch brred
    set -gx tide_time_format "(%H:%M)"
    set -gx tide_time_color brblack
    set -gx tide_os_color brblack
    set -gx fish_color_autosuggestion brblack
    set -gx tide_git_truncation_length 0
end
