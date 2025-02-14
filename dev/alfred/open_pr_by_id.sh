#!/bin/bash

# Base URL
BASE_URL="https://github.com/getlago/lago-api/pull"

# Check if a path is provided
if [ -z "$1" ]; then
	echo "Usage: $0 <url_path>"
	exit 1
fi

# Construct full URL
FULL_URL="$BASE_URL/$(echo "$1" | tr -cd '0-9')"

# Open URL in default browser
if command -v xdg-open &>/dev/null; then
	xdg-open "$FULL_URL" # Linux
elif command -v open &>/dev/null; then
	open "$FULL_URL" # macOS
elif command -v start &>/dev/null; then
	start "$FULL_URL" # Windows (Git Bash)
else
	echo "Could not detect the web browser command."
	exit 1
fi
