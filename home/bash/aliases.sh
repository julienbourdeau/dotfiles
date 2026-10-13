# cd previous directories
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'

alias l="ls -lhF"     # List all files in long format
alias ll="l -a"


# `tree` with hidden files and color enabled, ignoring
# the `.git` directory, listing directories first.
alias tree="tree -aC -I '.git|.idea|vendor|node_modules' --dirsfirst"

# Print each PATH entry on a separate line
alias show_path='echo -e ${PATH//:/\\n}'


alias localip="ipconfig getifaddr en0"

# Lago (getlago/lago) dev stack. Keep in sync with config/fish/config.fish.
# $LAGO_PATH comes from ~/.env and points at the Lago repo checkout.
if [ -n "$LAGO_PATH" ]; then
	# docker compose for the Lago dev stack, e.g. `lago ps`, `lago logs -f api`
	alias lago="docker compose -f $LAGO_PATH/docker-compose.dev.yml -f $LAGO_PATH/docker-compose.dev.local.yml"
	# Start backing services in the background (db, redis, traefik, mailpit, clickhouse)
	alias lagup-deamon="lago up -d db redis traefik mailpit clickhouse"
	# Backing services + API only (foreground, blocks)
	alias lagup-api="lagup-deamon && lago up api"
	# Full stack: backing services + front, api, workers, clock, pdf (foreground, blocks)
	alias lagup="lagup-deamon && lago up front api api-worker api-clock pdf"
	# Run bin/rails inside the running api container, e.g. `lagr console`, `lagr db:migrate`
	alias lagr="lago exec api bin/rails"
	# Stop every Lago service
	alias lago_stop="lago stop db redis traefik mailpit clickhouse redpanda front api api-worker api-clock pdf api-events-worker api-pdfs-worker api-billing-worker api-clock-worker api-webhook-worker"
fi
