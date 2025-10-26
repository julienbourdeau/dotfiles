# Julien’s dotfiles

![Screenshot of `git status`](https://private-user-images.githubusercontent.com/1525636/505619215-5960f52d-5352-450d-b53a-c22a241cf275.png?jwt=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTUiLCJleHAiOjE3NjEzODU1NzMsIm5iZiI6MTc2MTM4NTI3MywicGF0aCI6Ii8xNTI1NjM2LzUwNTYxOTIxNS01OTYwZjUyZC01MzUyLTQ1MGQtYjUzYS1jMjJhMjQxY2YyNzUucG5nP1gtQW16LUFsZ29yaXRobT1BV1M0LUhNQUMtU0hBMjU2JlgtQW16LUNyZWRlbnRpYWw9QUtJQVZDT0RZTFNBNTNQUUs0WkElMkYyMDI1MTAyNSUyRnVzLWVhc3QtMSUyRnMzJTJGYXdzNF9yZXF1ZXN0JlgtQW16LURhdGU9MjAyNTEwMjVUMDk0MTEzWiZYLUFtei1FeHBpcmVzPTMwMCZYLUFtei1TaWduYXR1cmU9NDAwOTZlNzk1NmY1NTVjNmIyNzlhYWE2OTZkOWU1MjYwYzkyZTNkNDdmYjA5MWUxYmY2NTgwN2E5OWMyYzI4MSZYLUFtei1TaWduZWRIZWFkZXJzPWhvc3QifQ.MeAH5pjm3xDmsP9ftSzwZUiisztBJp4pq6PXhHLWafk)


```
$ ./dot
Usage:
./dot [--dotfiles] [--sublime] [--php]

Options:
   -d | --dotfiles    Symlink dotfiles in home/ directory
   --php              Setup php prepended file
   --sublime          Symlink Sublime Text preferences

```

### Install Homebrew

```shell
curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh
```

### Setup fish prompt

```shell
brew install fish

brew update fish
brew install fisher
brew install terminal-notifier

fisher install IlanCosman/tide@v6
fisher install franciscolourenco/done
fisher install jethrokuan/z

tide configure --auto --style=Lean --prompt_colors='16 colors' --show_time='24-hour format' --lean_prompt_height='Two lines' --prompt_connection=Disconnected --prompt_spacing=Sparse --icons='Many icons' --transient=Yes

# if docker
#docker completion fish > ~/.config/fish/completions/docker.fish
```

### Brewfile



### Link configuration

`./dot --dotfiles` can be executed anytime.

Configure iTerm to use `misc/terminal`.

![](https://user-images.githubusercontent.com/1525636/201951710-1df49a04-7600-4e53-8bec-d0c4cbe0fe0c.png)

### 1password-cli (ssh-agent)

...

### TouchID for root password

Use TouchID to _sudo_ instead of password.
Source: https://davidwalsh.name/touch-sudo

```sh
# Open the sudo utility
sudo vi /etc/pam.d/sudo

# Add the following as the first line
auth sufficient pam_tid.so
```


```diff
# sudo: auth account password session
+ auth       sufficient     pam_tid.so
auth       sufficient     pam_smartcard.so
auth       required       pam_opendirectory.so
account    required       pam_permit.so
password   required       pam_deny.so
session    required       pam_permit.so
```


## Thanks to…

* [@mathiasbynens](https://github.com/mathiasbynens/dotfiles/) ([compare](https://github.com/mathiasbynens/dotfiles/compare/d6ca39a907123c0a7f874c500ba16cabb3156a63...master))
* [@paulmillr](https://github.com/paulmillr/dotfiles/) ([for vim config](https://github.com/paulmillr/vimrc/tree/5b472316d099fc1f6626ca790e81f6d021747c13) **NEEDS UPDATE**) 
* [@statico](https://github.com/statico/dotfiles/)
