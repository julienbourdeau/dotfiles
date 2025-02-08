# Heavily inspired by @necolas’s prompt: https://github.com/necolas/dotfiles
# iTerm → Profiles → Text → use 13pt Monaco with 1.1 vertical spacing.

if [[ $COLORTERM = gnome-* && $TERM = xterm ]] && infocmp gnome-256color >/dev/null 2>&1; then
	export TERM='gnome-256color'
elif infocmp xterm-256color >/dev/null 2>&1; then
	export TERM='xterm-256color'
fi

prompt_git() {
	local s=''
	local branchName=''

	# Check if the current directory is in a Git repository.
	if [ $(
		git rev-parse --is-inside-work-tree &>/dev/null
		echo "${?}"
	) == '0' ]; then

		# check if the current directory is in .git before running git checks
		if [ "$(git rev-parse --is-inside-git-dir 2>/dev/null)" == 'false' ]; then

			# Ensure the index is up to date.
			git update-index --really-refresh -q &>/dev/null

			# Check for uncommitted changes in the index.
			if ! $(git diff --quiet --ignore-submodules --cached); then
				s+='+'
			fi

			# Check for unstaged changes.
			if ! $(git diff-files --quiet --ignore-submodules --); then
				s+='!'
			fi

			# Check for untracked files.
			if [ -n "$(git ls-files --others --exclude-standard)" ]; then
				s+='?'
			fi

			# Check for stashed files.
			if $(git rev-parse --verify refs/stash &>/dev/null); then
				s+='$'
			fi

		fi

		# Get the short symbolic ref.
		# If HEAD isn’t a symbolic ref, get the short SHA for the latest commit
		# Otherwise, just give up.
		branchName="$(git symbolic-ref --quiet --short HEAD 2>/dev/null ||
			git rev-parse --short HEAD 2>/dev/null ||
			echo '(unknown)')"

		[ -n "${s}" ] && s=" [${s}]"

		echo -e "${1}${branchName}${2}${s}"
	else
		return
	fi
}

# Set the terminal title to the current working directory.
PS1="\[\033]0;\W\007\]"
PS1+="\n" # newline

if [[ ! "${SSH_TTY}" ]]; then

	# Show time, user and working dir path
	PS1+="\[${yellow}\](\A) " # time

	if [[ "${USER}" == "root" ]]; then
		PS1+="\[${red}\]\u" # username
	else
		PS1+="\[${blue}\]\u" # username
	fi

	PS1+="\[${black}\] in "
	PS1+="\[${green}\]\w" # working directory

	# Show git details
	PS1+="\$(prompt_git \"\[${black}\] on \[${red}\]\" \"\[${purple}\]\")"

else

	# Show time, user and working dir path
	PS1+="\[${reset}\][\[${blue}\]\A\[${reset}\]] " # time

	if [[ "${USER}" == "root" ]]; then
		userStyle="${red}" # username
	else
		userStyle="${green}" # username
	fi

	PS1+="\[${black}\]["
	PS1+="\[${userStyle}\]\u" # username
	PS1+="\[${yellow}\]@"
	PS1+="\[${userStyle}\]\h" # hostname
	PS1+="\[${black}\]] "

	PS1+="\[${black}\][\[${yellow}\]\w\[${black}\]] " # working directory

	# Show git details
	PS1+="\$(prompt_git \"\[${black}\]( \[${red}\]\" \"\[\[${black}\] )\[${purple}\]\")"

fi

PS1+="\n"
PS1+="\[${black}\]\$ \[${reset}\]" # `$` (and reset color)
export PS1

PS2="\[${yellow}\]→ \[${reset}\]"
export PS2
