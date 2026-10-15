# Git commits

Do not append a `Co-Authored-By: Claude …` trailer to commit messages.
Use only my configured git identity so author and committer match.

# Shell

GNU coreutils, sed, grep, awk and findutils come before the BSD tools in PATH
on this Mac: use GNU syntax (`sed -i` without `''`, `grep -P`, `date -d`,
`readlink -f`, `find -printf`).
