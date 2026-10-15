# AGENTS.md

Julien's macOS dotfiles. `dot.sh` symlinks everything into place; nothing is
copied (except `etc/env.example` → `~/.env` on first run).

## Shells (the important part)

- **fish** is the interactive shell, **bash** (Homebrew, `/opt/homebrew/bin/bash`)
  is the login shell, and **agents run bash**. Keep the two in sync.
- Shared, sourced by both shells — edit these first:
  - `home/shell/env.sh` → `~/.shell/env.sh`: only `export NAME=value` lines.
  - `home/shell/aliases.sh` → `~/.shell/aliases.sh`: only `alias name='value'` lines.
  - No conditionals, `$(...)`, or shell-specific syntax in those files: fish must parse them.
- Shell-specific: `home/bash_profile.sh` and `config/fish/config.fish`. The
  PATH list is duplicated in both; change both together.
- Bash's interactive-only block (prompt, `cat=bat`, colored `tree`) is skipped by
  agents. Don't put anything that changes standard command output outside it.
- New commands go in `home/bin/` (→ `~/.bin`, on PATH everywhere) as bash
  scripts, not fish functions.
- Secrets live in `~/.env` (not versioned), loaded by both shells.

## Layout and link rules

- `home/<dir>` → `~/.<dir>`; `home/<name>.sh` and `home/conf.<name>` → `~/.<name>`.
- `config/fish/**` → `~/.config/fish/**`.
- `etc/`: files with real names for editor highlighting, linked explicitly in
  `link_etc` (Brewfile, irbrc, Claude Code settings/CLAUDE.md for both profiles,
  mise config).
- `macos/defaults.yaml`: declarative `defaults(1)` manifest, see README.

## Checks

```sh
./dot.sh --dry-run --dotfiles
shellcheck dot.sh home/bin/* home/bash_profile.sh
bash -lc 'type gs lago git-fix-up'
fish -c 'type gs lago git-fix-up'
```
