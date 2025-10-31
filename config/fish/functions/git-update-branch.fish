function git-update-branch
    # Get the target branch (default to main)
    set -l target_branch main
    if test (count $argv) -gt 0
        set target_branch $argv[1]
    end

    # Check if we're in a git repository
    if not git rev-parse --git-dir > /dev/null 2>&1
        print_error "Not in a git repository"
        return 1
    end

    # Get current branch name
    set -l current_branch (git branch --show-current)

    if test -z "$current_branch"
        print_error "Not on a branch (detached HEAD state)"
        return 1
    end

    # Check if working directory is dirty
    set -l stashed 0
    if not git diff-index --quiet HEAD --
        echo "Working directory is dirty. Stashing changes..."
        git stash push -m "Auto-stash before rebasing on $target_branch"
        set stashed 1
    end

    # Checkout target branch and pull
    print_header "Checking out $target_branch..."
    if not git checkout $target_branch
        print_error "Failed to checkout $target_branch"
        test $stashed -eq 1; and git stash pop
        return 1
    end

    print_header "Pulling latest changes..."
    git pull

    # Switch back to feature branch
    print_header "Switching back to $current_branch..."
    git checkout $current_branch

    # Perform the rebase
    print_header "Rebasing $current_branch on $target_branch..."
    if git rebase $target_branch
        echo "✓ Rebase successful!"

        # Pop the stash if we stashed changes
        if test $stashed -eq 1
            echo "Applying stashed changes..."
            if git stash pop
                echo "✓ Stashed changes applied successfully"
            else
                echo "⚠ Warning: Conflicts while applying stash"
                return 1
            end
        end
    else
        echo
        echo "✗ Rebase failed. Fix conflicts and run 'git rebase --continue'"
        echo "Or abort with 'git rebase --abort'"
        echo

        if test $stashed -eq 1
            e_note "Your changes are stashed. Use 'git stash pop' after resolving the rebase."
        end
        return 1
    end

    gs
end
