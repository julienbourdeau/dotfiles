# Aliases shared by bash (~/.bash_profile) and fish (config.fish).
#
# Must stay parseable by BOTH shells: only `alias name='value'` lines and
# comments. Use single quotes so variables expand when the alias runs.
# Aliases that change the output of standard commands (cat, tree) are
# interactive-only and live in each shell's config, so agents get plain output.

alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'
alias o='open'

alias l='ls -lhF'     # List all files in long format
alias ll='l -a'

# Print each PATH entry on a separate line
alias show_path='printenv PATH | tr ":" "\n"'
alias localip='ipconfig getifaddr en0'

# Nice date format for git tags
alias tagdate="date '+%Y-%m-%d-%H%M%S'"

alias tailscale='/Applications/Tailscale.app/Contents/MacOS/Tailscale'
alias https='http --default-scheme=https'

# Trim new lines and copy to clipboard
alias c="tr -d '\n' | pbcopy"

# Git shortcuts
alias gs='git status && git lg -5'
alias gg='git add . && git commit -m'
alias gci='git commit -m'
alias grbase='git rebase -i --autosquash'
alias gc='git checkout'
alias gl='git lg -12'

# Dev shortcuts
alias art='php artisan'
alias r='bin/rails'

# Claude Code profiles
alias claude-work='CLAUDE_CONFIG_DIR=~/.claude-work claude'
alias claude-personal='CLAUDE_CONFIG_DIR=~/.claude-personal claude'

# Recursively delete `.DS_Store` files
alias rmdsstore="find . -type f -name '*.DS_Store' -ls -delete"

# Show/hide hidden files in Finder
alias showhiddenfiles='defaults write com.apple.finder AppleShowAllFiles -bool true && killall Finder'
alias hidehiddenfiles='defaults write com.apple.finder AppleShowAllFiles -bool false && killall Finder'

# Hide/show all desktop icons (useful when presenting)
alias hidedesktop='defaults write com.apple.finder CreateDesktop -bool false && killall Finder'
alias showdesktop='defaults write com.apple.finder CreateDesktop -bool true && killall Finder'

# Empty the Trash on all mounted volumes and the main HDD.
# Also, clear Apple’s System Logs to improve shell startup speed.
# Finally, clear download history from quarantine. https://mths.be/bum
alias emptytrash="sudo rm -rfv /Volumes/*/.Trashes; sudo rm -rfv ~/.Trash; sudo rm -rfv /private/var/log/asl/*.asl; sqlite3 ~/Library/Preferences/com.apple.LaunchServices.QuarantineEventsV* 'delete from LSQuarantineEvent'"

# Lago (getlago/lago) dev stack. $LAGO_PATH comes from ~/.env and points at the
# Lago repo checkout; it's expanded when the alias runs.
# docker compose for the Lago dev stack, e.g. `lago ps`, `lago logs -f api`
alias lago='docker compose -f "$LAGO_PATH/docker-compose.dev.yml" -f "$LAGO_PATH/docker-compose.dev.local.yml"'
# Start backing services in the background (db, redis, traefik, mailpit, clickhouse)
alias lagup-deamon='lago up -d db redis traefik mailpit clickhouse'
# Backing services + API only (foreground, blocks)
alias lagup-api='lagup-deamon && lago up api'
# Full stack: backing services + front, api, workers, clock, pdf (foreground, blocks)
alias lagup='lagup-deamon && lago up front api api-worker api-clock pdf'
# Run bin/rails inside the running api container, e.g. `lagr console`, `lagr db:migrate`
alias lagr='lago exec api bin/rails'
# Stop every Lago service
alias lago_stop='lago stop db redis traefik mailpit clickhouse redpanda front api api-worker api-clock pdf api-events-worker api-pdfs-worker api-billing-worker api-clock-worker api-webhook-worker'
