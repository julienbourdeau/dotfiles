function git-update-branch
    set -l target_branch (count $argv >/dev/null && echo $argv[1] || echo main)
    set -l current_branch (git branch --show-current)
    set -l stashed 0

    git diff --quiet || begin
        git stash
        set stashed 1
    end

    git checkout $target_branch && git pull && git checkout $current_branch && git rebase $target_branch

    test $stashed -eq 1 && git stash pop

    git lg -6
end
