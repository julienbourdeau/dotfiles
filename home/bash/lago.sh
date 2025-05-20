alias lago="docker compose -f $LAGO_PATH/docker-compose.dev.yml -f $LAGO_LICENSE_PATH/docker-compose.dev.yml"
alias lagup-deamon="lago up -d db redis traefik mailhog clickhouse license"
alias lagup-api="lagup-deamon && lago up api"
alias lagup="lagup-deamon && lago up front api api-worker api-clock pdf"
alias lagr="lago exec api bin/rails"
alias lagapi="lago exec api"
alias lago_stop="lago stop db redis traefik mailhog clickhouse redpanda license front api api-worker api-clock pdf api-events-worker api-pdfs-worker api-billing-worker api-clock-worker api-webhook-worker"
alias lago_rebuild="lago build db redis traefik mailhog clickhouse redpanda license front api api-worker api-clock pdf api-events-worker api-pdfs-worker api-billing-worker api-clock-worker api-webhook-worker"

function glagupdate() {
	if [ -z "$LAGO_PATH" ]; then
		echo "Error: \$LAGO_PATH is not defined."
		return 1
	fi

	e_title "Updating $LAGO_PATH/api"
	(cd "$LAGO_PATH"/api && gupdate main && bundle install && lago api exec bundle install && lago api exec bin/rails migrate)

	e_title "Updating $LAGO_PATH/front"
	(cd "$LAGO_PATH"/front && gupdate main)
}
