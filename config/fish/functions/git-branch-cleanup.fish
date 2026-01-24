function git-branch-cleanup
    # Parse arguments
    set -l dry_run 0
    set -l delay ""

    for arg in $argv
        switch $arg
            case --dry-run -n
                set dry_run 1
            case '*'
                set delay $arg
        end
    end

    if test -z "$delay"
        echo "Usage: git-branch-cleanup [--dry-run] <delay>"
        echo ""
        echo "Remove local branches that haven't been updated since <delay>."
        echo ""
        echo "Arguments:"
        echo "  delay       A date string like '6 months ago', '2 weeks ago', '1 year ago'"
        echo ""
        echo "Options:"
        echo "  --dry-run, -n   Show branches that would be deleted without deleting them"
        echo ""
        echo "Examples:"
        echo "  git-branch-cleanup '6 months ago'"
        echo "  git-branch-cleanup --dry-run '3 months ago'"
        return 1
    end

    # Check if we're in a git repository
    if not git rev-parse --git-dir >/dev/null 2>&1
        print_error "Not in a git repository"
        return 1
    end

    # Get current branch to avoid deleting it
    set -l current_branch (git branch --show-current)

    # Get the main/master branch name
    set -l main_branch (git symbolic-ref refs/remotes/origin/HEAD 2>/dev/null | sed 's@^refs/remotes/origin/@@')
    if test -z "$main_branch"
        # Fallback: check for main or master
        if git show-ref --verify --quiet refs/heads/main
            set main_branch main
        else if git show-ref --verify --quiet refs/heads/master
            set main_branch master
        end
    end

    if test -z "$cutoff_timestamp"
        set cutoff_timestamp (gdate -d "$delay" "+%s" 2>/dev/null)
    end

    # Track branches for deletion
    set -l branches_to_delete

    if test $dry_run -eq 1
        print_header "Branches that would be deleted (last commit before $delay):"
        echo ""
    end

    for branch in (git for-each-ref --format='%(refname:short)' refs/heads/)
        # Skip current branch
        if test "$branch" = "$current_branch"
            continue
        end

        # Skip main/master branch
        if test "$branch" = "$main_branch"
            continue
        end

        # Get the timestamp of the branch's HEAD commit
        set -l branch_timestamp (git log -1 --format=%ct "$branch" 2>/dev/null)

        # Branch is old if its last commit timestamp is before the cutoff
        if test -n "$branch_timestamp" -a "$branch_timestamp" -lt "$cutoff_timestamp"
            set -l commit_hash_short (git log -1 --format=%h "$branch")
            set -l commit_hash_full (git log -1 --format=%H "$branch")
            set -l commit_message (git log -1 --format=%s "$branch")
            set -l commit_date (git log -1 --format=%cr "$branch")

            if test $dry_run -eq 1
                printf "  %-40s %s (%s)\n" "$branch" "$commit_hash_short" "$commit_date"
                printf "    └─ %s\n\n" "$commit_message"
            else
                # Delete the branch and print info for recovery
                if git branch -D "$branch" >/dev/null 2>&1
                    echo "Deleted: $branch ($commit_hash_short)"
                    echo "  Restore with: git checkout -b $branch $commit_hash_full"
                else
                    print_error "Failed to delete branch: $branch"
                end
            end
            set -a branches_to_delete $branch
        end
    end

    if test (count $branches_to_delete) -eq 0
        echo "No branches found older than $delay"
        return 0
    end

    if test $dry_run -eq 1
        echo ""
        echo "Total: "(count $branches_to_delete)" branch(es) would be deleted"
        echo "Run without --dry-run to delete them"
    else
        echo ""
        echo "Deleted "(count $branches_to_delete)" branch(es)"
    end
end
