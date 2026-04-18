#!/usr/bin/env bash
#
# macOS defaults driver. Reads/writes the declarative manifest next to it.
#
#   ./macos/defaults.sh apply     # apply every value from the manifest
#   ./macos/defaults.sh export    # read system values, rewrite the manifest
#   ./macos/defaults.sh diff      # show which manifest values differ from system
#
# Requires: yq (mikefarah, v4+).

set -euo pipefail

here="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
manifest="$here/defaults.yaml"

if ! command -v yq >/dev/null 2>&1; then
	echo "yq not found (brew install yq)" >&2
	exit 1
fi

# Emit every (domain, key, type, value) tuple as TSV.
iter_manifest() {
	yq '.defaults | to_entries | .[] as $d |
	    ($d.value | to_entries | .[] |
	       [$d.key, .key, .value.type, .value.value]) | @tsv' "$manifest"
}

# Read the current value of (domain, key) from the system and translate it
# into the lexical form we store in YAML (true/false for bool, raw for the
# rest). Returns non-zero if the key is unset.
read_system_value() {
	local domain="$1" key="$2" type="$3"
	local raw
	if ! raw="$(defaults read "$domain" "$key" 2>/dev/null)"; then
		return 1
	fi
	case "$type" in
		bool)
			[[ "$raw" == "1" ]] && echo "true" || echo "false"
			;;
		*)
			echo "$raw"
			;;
	esac
}

cmd_apply() {
	local domain key type value
	while IFS=$'\t' read -r domain key type value; do
		echo "→ $domain $key = $value ($type)"
		defaults write "$domain" "$key" "-$type" "$value"
	done < <(iter_manifest)

	while IFS= read -r app; do
		[[ -z "$app" ]] && continue
		echo "↻ restarting $app"
		killall "$app" 2>/dev/null || true
	done < <(yq '.restart[]' "$manifest")
}

cmd_export() {
	local domain key type _old current
	while IFS=$'\t' read -r domain key type _old; do
		if ! current="$(read_system_value "$domain" "$key" "$type")"; then
			echo "⚠ skip (unset): $domain $key" >&2
			continue
		fi
		case "$type" in
			bool)
				DOMAIN="$domain" KEY="$key" VAL="$current" \
					yq -i '.defaults[strenv(DOMAIN)][strenv(KEY)].value = (env(VAL) == "true")' "$manifest"
				;;
			int|float)
				DOMAIN="$domain" KEY="$key" VAL="$current" \
					yq -i '.defaults[strenv(DOMAIN)][strenv(KEY)].value = (env(VAL) | to_number)' "$manifest"
				;;
			string)
				DOMAIN="$domain" KEY="$key" VAL="$current" \
					yq -i '.defaults[strenv(DOMAIN)][strenv(KEY)].value = strenv(VAL)' "$manifest"
				;;
			*)
				echo "⚠ unknown type '$type' for $domain $key" >&2
				;;
		esac
		echo "← $domain $key = $current"
	done < <(iter_manifest)
}

cmd_diff() {
	local domain key type value current status=0
	while IFS=$'\t' read -r domain key type value; do
		if ! current="$(read_system_value "$domain" "$key" "$type")"; then
			printf "%-20s %s %s  manifest=%s  system=<unset>\n" "[unset]" "$domain" "$key" "$value"
			status=1
			continue
		fi
		if [[ "$current" != "$value" ]]; then
			printf "%-20s %s %s  manifest=%s  system=%s\n" "[differ]" "$domain" "$key" "$value" "$current"
			status=1
		fi
	done < <(iter_manifest)
	return $status
}

cmd="${1:-}"
case "$cmd" in
	apply)  cmd_apply ;;
	export) cmd_export ;;
	diff)   cmd_diff ;;
	*)
		echo "Usage: $0 {apply|export|diff}" >&2
		exit 2
		;;
esac
