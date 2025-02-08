#### EASY COLORS ###
export bold=''
export reset="\e[0m"
export black="\e[1;30m"
export red="\e[31m"
export green="\e[32m"
export yellow="\e[1;33m"
export blue="\e[1;34m"
export purple="\e[1;35m"
export cyan="\e[36m"
export white="\e[1;37m"

# Headers and messages
function e_title() {
	echo
	echo
	printf "\n${purple}---------------------------------------------------${reset}\n" "$@"
	printf "\n${purple}    %s ${reset}\n" "$@"
	printf "\n${purple}---------------------------------------------------${reset}\n" "$@"
	echo
}
function e_header() {
	printf "\n\n${yellow}==========  %s  ==========${reset}\n" "$@"
}
function e_arrow() {
	printf "➜ %s\n" "$@"
}
function e_success() {
	printf "${green}✔ %s${reset}\n" "$@"
}
function e_error() {
	printf "${red}✖ %s${reset}\n" "$@"
}
function e_warning() {
	printf "${purple}➜ %s${reset}\n" "$@"
}
function e_note() {
	printf "${blue}Note: %s${reset}\n" "$@"
}

export -f e_header e_arrow e_success e_error e_warning e_note

function load_file() {
	[ -r "$1" ] && [ -f "$1" ] && source "$1"
}

function load_all_files() {
	for file in $1; do
		[ -r "$file" ] && [ -f "$file" ] && source "$file"
	done
}
