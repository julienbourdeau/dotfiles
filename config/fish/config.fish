
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
# Comment until I try if this is necessary with `mise`
# export GO111MODULE=on
# export GOPROXY="https://proxy.golang.org,direct"
# export GOPATH="$HOME/etc/go"
# fish_add_path --path $GOPATH/bin

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

alias show_path="string split ':' $PATH"
alias localip="ipconfig getifaddr en0"


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
    alias cat=bat
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

alias https='http --default-scheme=https'
alias urlencode='python -c "import sys, urllib as ul; print ul.quote_plus(sys.argv[1]);"'


# Recursively delete `.DS_Store` files
alias rmdsstore="find . -type f -name '*.DS_Store' -ls -delete"

# Empty the Trash on all mounted volumes and the main HDD.
# Also, clear Apple’s System Logs to improve shell startup speed.
# Finally, clear download history from quarantine. https://mths.be/bum
alias emptytrash="sudo rm -rfv /Volumes/*/.Trashes; sudo rm -rfv ~/.Trash; sudo rm -rfv /private/var/log/asl/*.asl; sqlite3 ~/Library/Preferences/com.apple.LaunchServices.QuarantineEventsV* 'delete from LSQuarantineEvent'"

# LAGO-specific shortcuts
# $LAGO_PATH must be present and it's loaded from ~/.env so I think I can't extract to functions/
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

function ts2utc
  set -l ts $argv[1]
	TZ="UTC" date -d @$ts -u "+%Y-%m-%d  %H:%M:%S  %Z (%:z)"
end

function dot
	set dotfiles_dir "$HOME/etc/dotfiles"
	cd $dotfiles_dir || echo "not found"
	idea $dotfiles_dir
	gs
end

function show_size
    set -l path $argv[1]
    if test -z "$path"
        set path .
    end
    du -sbh $path/*
end
