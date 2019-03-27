[user]
	name = Julien Bourdeau
	email = julien@sigerr.org

[github]
	user = julienbourdeau

[help]
    autocorrect = 1

[color]
	ui = auto

[color "branch"]
	current = green reverse

[color "diff"]
	meta = yellow bold
	frag = magenta bold # line info

[color "status"]
	changed = yellow
	untracked = cyan

[alias]
	# List all aliases
	la = "!git config -l | grep alias | cut -c 7-"

	br = branch -vv --sort=-committerdate
	st = status
	stu = status --untracked-files=no
	latest = "for-each-ref --sort=-committerdate --format='%(committerdate:short) %(refname:short) [%(committername)]'"

	# Commits
	cp = cherry-pick -x
	oops = commit --amend --no-edit
	# Random commit message from whatthecommit.com
	ci-rnd = !sh -c \"git commit -m '$(curl -s http://whatthecommit.com/index.txt)'\"

	# Logs & history
	lg = log --graph --pretty=tformat:'%C(red)%h%Creset -%C(auto)%d%Creset %s %Cgreen(%an %ar)%Creset' -10
	ll = log --pretty=format:"%C(red)%h%C(auto)%d\\ %C(reset)%s%C(green)\\ [%cn]%C(reset)" --decorate --numstat -20
	filelog = log -u -3
	f = "!git ls-files | grep -i"
	changelog = "!_() { t=$(git describe --abbrev=0 --tags); git log ${t}..HEAD --no-merges --pretty=format:'* %s'; }; _"

	# Workflow & Management
	ours = "!f() { git co --ours $@ && git add $@; }; f"
	theirs = "!f() { git co --theirs $@ && git add $@; }; f"
	done = "!f() { git branch | grep "$1" | cut -c 3- | grep -v done | xargs -I{} git branch -m {} done-{}; }; f"
	# Example: git ignore laravel,osx,phpstorm
	ignore = "!gi() { curl -L -s https://www.gitignore.io/api/$@ >> .gitignore ;}; gi"


[core]
	pager = cat
	editor = vim #atom --wait
	mergeoptions = --no-edit
	# Treat spaces before tabs and all kinds of trailing whitespace as an error
	# [default] trailing-space: looks for spaces at the end of a line
	# [default] space-before-tab: looks for spaces before tabs at the beginning of a line
	whitespace = space-before-tab,-indent-with-non-tab,trailing-space
	# Make `git rebase` safer on OS X
	# More info: <http://www.git-tower.com/blog/make-git-rebase-safe-on-osx/>
	trustctime = false
	# Prevent showing files whose names contain non-ASCII symbols as unversioned.
	# http://michael-kuehnel.de/git/2014/11/21/git-mac-osx-and-german-umlaute.html
	precomposeunicode = false
	excludesfile = ~/.gitignore_global

[apply]
	# Detect whitespace errors when applying a patch
	whitespace = fix

[diff]
	mnemonicPrefix = true
	renames = true
	wordRegex = .
	submodule = log

[fetch]
	recurseSubmodules = on-demand

[grep]
	extendedRegexp = true

[log]
	abbrevCommit = true

[merge]
	conflictStyle = diff3
	# Include summaries of merged commits in newly created merge commit messages
	log = true

[mergetool]
	keepBackup = false
	keepTemporaries = false
	prompt = false

[pull]
	rebase = preserve

[push]
	default = upstream

[rerere]
	# If, like me, you like rerere, decomment these
	autoupdate = true
	enabled = true

[status]
	submoduleSummary = true
	showUntrackedFiles = all

[tag]
	sort = version:refname


# URL shorthands

[url "git@github.com:"]

	insteadOf = "gh:"
	pushInsteadOf = "github:"
	pushInsteadOf = "git://github.com/"

[url "git://github.com/"]

	insteadOf = "github:"

[url "git@gist.github.com:"]

	insteadOf = "gst:"
	pushInsteadOf = "gist:"
	pushInsteadOf = "git://gist.github.com/"

[url "git://gist.github.com/"]

	insteadOf = "gist:"

[filter "lfs"]
	clean = git-lfs clean -- %f
	smudge = git-lfs smudge -- %f
	required = true
	process = git-lfs filter-process

[difftool "sourcetree"]
	cmd = opendiff \"$LOCAL\" \"$REMOTE\"
	path = 
[mergetool "sourcetree"]
	cmd = /Applications/Sourcetree.app/Contents/Resources/opendiff-w.sh \"$LOCAL\" \"$REMOTE\" -ancestor \"$BASE\" -merge \"$MERGED\"
	trustExitCode = true
