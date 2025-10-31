# Julien’s dotfiles

![Screenshot of `git status`](./docs/prompt.png)


```
❯ ./dot.sh
Usage:
./dot.sh [--dotfiles] [--sublime] [--hosts] [--homebrew-bash] [--php]

Options:
   -d | --dotfiles    Symlink dotfiles in home/ directory
   -h | --hosts       Create local hosts files and symlink it
   --php              Setup php prepended file
   --sublime          Symlink Sublime Text preferences
   --homebrew-bash    Add bash from homebrew to shell login and switch to it
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

tide configure --auto --style=Lean --prompt_colors='16 colors' --show_time='24-hour format' --lean_prompt_height='Two lines' --prompt_connection=Disconnected --prompt_spacing=Sparse --icons='Many icons' --transient=No

# if docker
#docker completion fish > ~/.config/fish/completions/docker.fish
```

Install Nerd Font: [MesloLGS NF](https://github.com/ryanoasis/nerd-fonts/tree/master/patched-fonts/Meslo/S)

### Brewfile



### Link configuration

`./dot --dotfiles` can be executed anytime.

Configure iTerm to use `misc/terminal`.

![Iterm configuration screenshot](./docs/iterm-config.png)

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
