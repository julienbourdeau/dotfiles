[user]
  name = Julien Bourdeau
  email = julien@sigerr.org

[github]
  user = julienbourdeau

[color]
  ui = auto

# [color "branch"]

#   current = yellow reverse
#   local = yellow
#   remote = green

# [color "diff"]

#   meta = yellow bold
#   frag = magenta bold # line info
#   old = red # deletions
#   new = green # additions

# [color "status"]

#   added = yellow
#   changed = green
#   untracked = cyan

[alias]
  st = status
  ci = commit
  lg = log --graph --pretty=tformat:'%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%an %ar)%Creset'
  oops = commit --amend --no-edit

  # Merge GitHub pull request on top of the `master` branch
  # mpr = "!f() { \
  #   if [ $(printf \"%s\" \"$1\" | grep '^[0-9]\\+$' > /dev/null; printf $?) -eq 0 ]; then \
  #     git fetch origin refs/pull/$1/head:pr/$1 && \
  #     git rebase master pr/$1 && \
  #     git checkout master && \
  #     git merge pr/$1 && \
  #     git branch -D pr/$1 && \
  #     git commit --amend -m \"$(git log -1 --pretty=%B)\n\nCloses #$1.\"; \
  #   fi \
  # }; f"

[core]
  pager = cat
  editor = subl -w
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
  # This is GREAT… when you know what you're doing and are careful
  # not to pull --no-rebase over a local line containing a true merge.
  # rebase = true
  # WARNING! This option, which does away with the one gotcha of
  # auto-rebasing on pulls, is only available from 1.8.5 onwards.
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
