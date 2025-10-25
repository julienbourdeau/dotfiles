
if test -f "$HOME/.env"
    for envvar in (grep -v '^#' $HOME/.env | xargs -n1)
        set -gx (string split '=' $envvar)
    end
end

# Setup brew
eval "$(/opt/homebrew/bin/brew shellenv)"

fish_add_path /usr/local/bin
fish_add_path ~/.bin
fish_add_path ~/.composer/vendor/bin
fish_add_path ~/.cargo/bin
fish_add_path ~/Library/Application Support/Herd/bin/
fish_add_path ~/.composer/vendor/bin

fish_add_path "$(brew --prefix)/opt/coreutils/libexec/gnubin"
fish_add_path "$(brew --prefix)/opt/gnu-sed/libexec/gnubin"
fish_add_path "$(brew --prefix)/opt/findutils/libexec/gnubin"

export HOMEBREW_NO_ENV_HINTS=1

export EDITOR='vim'
export VISUAL='fleet'
export LANG='en_US.UTF-8'
export LC_ALL='en_US.UTF-8'

export PAGER=bat
export BAT_THEME=GitHub

export SSH_AUTH_SOCK=~/.1password/agent.sock

# Golang
export GO111MODULE=on
export GOPROXY="https://proxy.golang.org,direct"
export GOPATH="$HOME/etc/go"
fish_add_path --path $GOPATH/bin

# Ensure ruby always load my personal config
if test -f "$HOME/.ruby/boot.rb"
    export RUBYOPT="-I$HOME/.ruby/ -r boot"
end

# == Aliases

alias l="ls -lhF"     # List all files colorized in long format
alias ll="l -a"

# `tree` with hidden files and color enabled, ignoring
# the `.git` directory, listing directories first.
alias tree="tree -aC -I '.git|.idea|vendor|node_modules' --dirsfirst"

# Nice date format for git tags
alias tagdate="date '+%Y-%m-%d-%H%M%S'"

# Git shortcuts
alias gut=git
alias got=git
alias gs='git status && git lg -5'
alias gg='git add . && git commit -m'
alias gci='git commit -m'
alias grbase='git rebase -i --autosquash'
alias gc='git checkout'
alias gl='git lg -12'

# Dev shortcuts
alias composer="COMPOSER_MEMORY_LIMIT=-1 composer"
alias art='php artisan'
alias be='bundle exec'
alias rake='rake -s'
alias r='bin/rails'
alias j='z' # autojump -> zoxide

if command -v bat > /dev/null 2>&1
    alias cat bat
end

# Trim new lines and copy to clipboard
alias c="tr -d '\n' | pbcopy"

# Recursively delete `.DS_Store` files
alias rmdsstore="find . -type f -name '*.DS_Store' -ls -delete"

# Show/hide hidden files in Finder
alias showhiddenfiles="defaults write com.apple.finder AppleShowAllFiles -bool true && killall Finder"
alias hidehiddenfiles="defaults write com.apple.finder AppleShowAllFiles -bool false && killall Finder"

# Hide/show all desktop icons (useful when presenting)
alias hidedesktop="defaults write com.apple.finder CreateDesktop -bool false && killall Finder"
alias showdesktop="defaults write com.apple.finder CreateDesktop -bool true && killall Finder"

# Merge PDF files
# Usage: `mergepdf -o output.pdf input{1,2,3}.pdf`
alias mergepdf='/System/Library/Automator/Combine\ PDF\ Pages.action/Contents/Resources/join.py'

# One of @janmoesen’s ProTip™s
for method in GET HEAD POST PUT DELETE TRACE OPTIONS
    alias $method "lwp-request -m $method"
end


# LAGO-specific shortcuts
if test -n "$LAGO_PATH"
  alias lago="docker compose -f $LAGO_PATH/docker-compose.dev.yml -f $LAGO_LICENSE_PATH/docker-compose.dev.yml"
  alias lagup-deamon="lago up -d db redis traefik mailhog clickhouse license"
  alias lagup-api="lagup-deamon && lago up api"
  alias lagup-app="lagup-deamon && lago up api front"
  alias lagup-dev="lago up -d db redis traefik license && LAGO_CLICKHOUSE_ENABLED=false LAGO_CLICKHOUSE_MIGRATIONS_ENABLED=false LAGO_DISABLE_PDF_GENERATION=true lago up api"
  alias lagup="lagup-deamon && lago up front api api-worker api-clock pdf"
  alias lagr="lago exec api bin/rails"
  alias lagapi="lago exec api"
  alias lago_stop="lago stop db redis traefik mailhog clickhouse redpanda license front api api-worker api-clock pdf api-events-worker api-pdfs-worker api-billing-worker api-clock-worker api-webhook-worker"
  alias lago_rebuild="lago build migrate db redis traefik mailhog clickhouse redpanda license front api api-worker api-clock pdf api-events-worker api-pdfs-worker api-billing-worker api-clock-worker api-webhook-worker"
end

set -gx tide_git_color_branch brred
set -gx tide_time_format "(%H:%M)"
set -gx tide_time_color white
set -gx tide_os_color white
set -gx fish_color_autosuggestion white
set -gx tide_git_truncation_length 0

if status is-interactive
    # Commands to run in interactive sessions can go here
end


function git-rebase-on
    # Get the target branch (default to main)
    set -l target_branch main
    if test (count $argv) -gt 0
        set target_branch $argv[1]
    end

    # Check if we're in a git repository
    if not git rev-parse --git-dir > /dev/null 2>&1
        echo "Error: Not in a git repository"
        return 1
    end

    # Get current branch name
    set -l current_branch (git branch --show-current)

    if test -z "$current_branch"
        echo "Error: Not on a branch (detached HEAD state)"
        return 1
    end

    # Check if working directory is dirty
    if not git diff-index --quiet HEAD --
        echo "Working directory is dirty. Stashing changes..."
        git stash push -m "Auto-stash before rebasing on $target_branch"
        set -l stashed 1
    else
        set -l stashed 0
    end

    # Checkout target branch and pull
    echo "Checking out $target_branch..."
    if not git checkout $target_branch
        echo "Error: Failed to checkout $target_branch"
        test $stashed -eq 1; and git stash pop
        return 1
    end

    echo "Pulling latest changes..."
    git pull

    # Switch back to feature branch
    echo "Switching back to $current_branch..."
    git checkout $current_branch

    # Perform the rebase
    echo "Rebasing $current_branch on $target_branch..."
    if git rebase $target_branch
        echo "✓ Rebase successful!"

        # Pop the stash if we stashed changes
        if test $stashed -eq 1
            echo "Applying stashed changes..."
            if git stash pop
                echo "✓ Stashed changes applied successfully"
            else
                echo "⚠ Warning: Conflicts while applying stash"
                return 1
            end
        end
    else
        echo "✗ Rebase failed. Fix conflicts and run 'git rebase --continue'"
        echo "Or abort with 'git rebase --abort'"

        if test $stashed -eq 1
            echo "Note: Your changes are stashed. Use 'git stash pop' after resolving the rebase."
        end
        return 1
    end
end
