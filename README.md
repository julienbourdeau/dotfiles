# Julien’s dotfiles

## Installation

### Using Git and the bootstrap script

Clone this repository in `~/Projects`. The bootstrapper script will pull in the latest version and symlink the files to your home folder.

```bash
git clone https://github.com/julienbourdeau/dotfiles.git && cd dotfiles && bash symlink-dotfiles.sh
```


### Add custom commands

If `~/.extra` exists, it will be sourced along with the other files. You can use this to add a few custom commands you don’t want to commit to a public repository.


### Install Homebrew formulas

Install [Homebrew](http://brew.sh/)

```bash
./etc/brew.sh
./etc/cask.sh
```

### Switch Shell

```bash
./switch-bash.sh
```

##### Note

[Compare from d6ca39a907123c0a7f874c500ba16cabb3156a63](https://github.com/mathiasbynens/dotfiles/compare/d6ca39a907123c0a7f874c500ba16cabb3156a63...master)

## Thanks to…

* [@mathiasbynens](https://github.com/mathiasbynens/dotfiles/)
* [@paulmillr](https://github.com/paulmillr/dotfiles/)
* [@statico](https://github.com/statico/dotfiles/)
