#!/usr/bin/env bash

function dot() {
	dotfiles_dir="$HOME/etc/dotfiles"
	cd $dotfiles_dir || echo "not found"
	idea $dotfiles_dir
	gs
}

function update() {
	e_arrow "Update App Store software"
	sudo softwareupdate -i -a

	e_arrow "Update Homebrew software"
	brew update
	brew upgrade
	brew cleanup

	e_arrow "Update global Node packages"
	nvm use default
	npm update -g

	e_arrow "Update global Ruby gems"
	sudo gem update --system
	sudo gem update bundler rubocop
	sudo gem cleanup

	e_arrow "Update global Composer packages"
	composer global update

	e_success "Everything is up-to-date"
}

# Create a new directory and enter it
function mkd() {
	mkdir -p "$@" && cd "$_"
}

# Create a .tar.gz archive, using `zopfli`, `pigz` or `gzip` for compression
function targz() {
	local tmpFile="${@%/}.tar"
	tar -cvf "${tmpFile}" --exclude=".DS_Store" "${@}" || return 1

	size=$(
		stat -f"%z" "${tmpFile}" 2>/dev/null # OS X `stat`
		stat -c"%s" "${tmpFile}" 2>/dev/null # GNU `stat`
	)

	local cmd=""
	if ((size < 52428800)) && hash zopfli 2>/dev/null; then
		# the .tar file is smaller than 50 MB and Zopfli is available; use it
		cmd="zopfli"
	else
		if hash pigz 2>/dev/null; then
			cmd="pigz"
		else
			cmd="gzip"
		fi
	fi

	echo "Compressing .tar ($((size / 1000)) kB) using \`${cmd}\`…"
	"${cmd}" -v "${tmpFile}" || return 1
	[ -f "${tmpFile}" ] && rm "${tmpFile}"

	zippedSize=$(
		stat -f"%z" "${tmpFile}.gz" 2>/dev/null # OS X `stat`
		stat -c"%s" "${tmpFile}.gz" 2>/dev/null # GNU `stat`
	)

	echo "${tmpFile}.gz ($((zippedSize / 1000)) kB) created successfully."
}

# Determine size of a file or total size of a directory
function showsize() {
	if du -b /dev/null >/dev/null 2>&1; then
		local arg=-sbh
	else
		local arg=-sh
	fi
	if [[ -n "$@" ]]; then
		du $arg -- "$@"
	else
		du $arg .[^.]* ./*
	fi
}

# Create a data URL from a file
function dataurl() {
	local mimeType=$(file -b --mime-type "$1")
	if [[ $mimeType == text/* ]]; then
		mimeType="${mimeType};charset=utf-8"
	fi
	echo "data:${mimeType};base64,$(openssl base64 -in "$1" | tr -d '\n')"
}

# Compare original and gzipped file size
function gz() {
	local origsize=$(wc -c <"$1")
	local gzipsize=$(gzip -c "$1" | wc -c)
	local ratio=$(echo "$gzipsize * 100 / $origsize" | bc -l)
	printf "orig: %d bytes\n" "$origsize"
	printf "gzip: %d bytes (%2.2f%%)\n" "$gzipsize" "$ratio"
}

# Syntax-highlight JSON strings or files
# Usage: `json '{"foo":42}'` or `echo '{"foo":42}' | json`
function json() {
	if [ -t 0 ]; then # argument
		python -mjson.tool <<<"$*" | pygmentize -l javascript
	else # pipe
		python -mjson.tool | pygmentize -l javascript
	fi
}

# Run `dig` and display the most useful info
function digga() {
	dig +nocmd "$1" any +multiline +noall +answer
}

# UTF-8-encode a string of Unicode symbols
function escape() {
	printf "\\\x%s" $(printf "$@" | xxd -p -c1 -u)
	# print a newline unless we’re piping the output to another program
	if [ -t 1 ]; then
		echo "" # newline
	fi
}

# Decode \x{ABCD}-style Unicode escape sequences
function unidecode() {
	perl -e "binmode(STDOUT, ':utf8'); print \"$@\""
	# print a newline unless we’re piping the output to another program
	if [ -t 1 ]; then
		echo "" # newline
	fi
}

# Get a character’s Unicode code point
function codepoint() {
	perl -e "use utf8; print sprintf('U+%04X', ord(\"$@\"))"
	# print a newline unless we’re piping the output to another program
	if [ -t 1 ]; then
		echo "" # newline
	fi
}

# Show all the names (CNs and SANs) listed in the SSL certificate
# for a given domain
function getcertnames() {
	if [ -z "${1}" ]; then
		echo "ERROR: No domain specified."
		return 1
	fi

	local domain="${1}"
	echo "Testing ${domain}…"
	echo "" # newline

	local tmp=$(echo -e "GET / HTTP/1.0\nEOT" |
		openssl s_client -connect "${domain}:443" -servername "${domain}" 2>&1)

	if [[ "${tmp}" = *"-----BEGIN CERTIFICATE-----"* ]]; then
		local certText=$(echo "${tmp}" |
			openssl x509 -text -certopt "no_aux, no_header, no_issuer, no_pubkey, \
			no_serial, no_sigdump, no_signame, no_validity, no_version")
		echo "Common Name:"
		echo "" # newline
		echo "${certText}" | grep "Subject:" | sed -e "s/^.*CN=//" | sed -e "s/\/emailAddress=.*//"
		echo "" # newline
		echo "Subject Alternative Name(s):"
		echo "" # newline
		echo "${certText}" | grep -A 1 "Subject Alternative Name:" |
			sed -e "2s/DNS://g" -e "s/ //g" | tr "," "\n" | tail -n +2
		return 0
	else
		echo "ERROR: Certificate not found."
		return 1
	fi
}

# `o` with no arguments opens the current directory, otherwise opens the given
# location
function o() {
	if [ $# -eq 0 ]; then
		open .
	else
		open "$@"
	fi
}

function vault_login() {
	vault login -method=userpass username=$VAULT_USERNAME password=$VAULT_PASSWORD
}

function migrate() {
	if test -f "artisan"; then
		e_arrow "Running Laravel migrations"
		php artisan migrate
	elif test -f "bin/rails"; then
		e_arrow "Running Rails migrations"
		bin/rails db:migrate
	fi
}

function ts2utc() {
	TZ="UTC" date -d @$1 -u "+%Y-%m-%d  %H:%M:%S  %Z (%:z)"
}

function node_upgrade() {
	if [ -z "$1" ]; then
		e_error "ERROR: No version specified. Please provide a Node.js version."
		return 1
	fi

	e_header "Upgrading Node.js..."
	nvm install $1
	nvm use $1
	nvm alias default $1

	e_header "Reinstalling global npm packages..."
	npm install -g yarn esling prettier doctoc
	npm update -g
	e_note "Using Node $(node -v) and NPM $(npm -v)"
	echo
	npm -g list

	e_success "Upgrade complete!"
}
alias nvm_upgrade=node_upgrade

function ruby_upgrade() {
	if [ -z "$1" ]; then
		e_error "ERROR: No version specified. Please provide a Ruby version (as X.Y.Z)."
		return 1
	fi

	e_header "Upgrading Ruby..."
	rbenv install $1
	if [ $? -ne 0 ]; then
		e_error "ERROR: Previous command failed. Stopping the upgrade process."
		return 1
	fi
	rbenv shell $1

	e_header "Reinstalling basic gems..."
	gem install bundler irb rubocop standard rails awesome_print
	npm update -g
	e_note "Using $(ruby -v)\n with $(rbenv -v), $(bundle -v) and $(irb -v)"

	echo
	rbenv versions
	echo
	e_arrow "To set $1 as global default"
	echo "rbenv global $1"

	echo
	e_success "Upgrade complete!"
}
