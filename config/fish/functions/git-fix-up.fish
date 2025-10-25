function git-fix-up
    if test (count $argv) -eq 0
        echo "Usage: git-fix-up <commit-hash>"
        return 1
    end

    if git diff --cached --quiet
        echo "Error: No staged changes to commit"
        return 1
    end

    set -l commit_hash $argv[1]
    git commit --fixup=$commit_hash && git rebase -i --autosquash $commit_hash^
end