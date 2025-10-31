# Color variables - globally available
set -g reset "\e[0m"
set -g bold "\e[1m"
set -g dim "\e[2m"
set -g black "\e[30m"
set -g red "\e[31m"
set -g green "\e[32m"
set -g yellow "\e[33m"
set -g blue "\e[34m"
set -g purple "\e[35m"
set -g cyan "\e[36m"
set -g white "\e[37m"
set -g gray "\e[90m"

# Bright colors
set -g bright_red "\e[91m"
set -g bright_green "\e[92m"
set -g bright_yellow "\e[93m"
set -g bright_blue "\e[94m"
set -g bright_purple "\e[95m"
set -g bright_cyan "\e[96m"
set -g bright_white "\e[97m"

# Color printing functions
function print_color
    set color $argv[1]
    set message $argv[2..-1]
    printf "$color%s$reset\n" "$message"
end

# Status message functions
function print_success
    printf "$green✓ %s$reset\n" $argv
end

function print_error
    printf "$red$bold✗ Error:$reset$red %s$reset\n" $argv
end

function print_warning
    printf "$yellow⚠️%s$reset\n" $argv
end

function print_note
    printf "$bold$blue""Note: $reset$blue%s""$reset\n" $argv
end


# Title functions
function print_title
    set title $argv
    set title_length (string length "$title")
    set border_length (math "max(50, $title_length + 10)")
    set border (string repeat -n $border_length "=")
    set padding (math "($border_length - $title_length - 2) / 2")
    set left_pad (string repeat -n $padding " ")
    set right_pad (string repeat -n (math "$border_length - $title_length - 2 - $padding") " ")

    echo
    print_color $bright_blue $border
    print_color $bright_blue "$left_pad$title$right_pad"
    print_color $bright_blue $border
    echo
end

function print_section
    set section $argv
    echo
    print_color $bright_yellow "── $section ──"
    echo
end

function print_header
    set header $argv
    echo
    print_color $purple "▶ $header"
end

function print_separator
    print_color $gray (string repeat -n 60 "─")
end
