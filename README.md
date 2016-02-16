# Julien’s dotfiles

## TODO

* [ ] Clean aliases
* [x] sudo ln -s ~/Projects/dotfiles/etc/hosts /etc/hosts
* [x] cp /Users/julien/Projects/dotfiles/sublime/Sublime\ Text.icns /Applications/Sublime\ Text.app/Contents/Resources/Sublime\ Text.icns


* [ ] Create locate database `sudo launchctl load -w /System/Library/LaunchDaemons/com.apple.locate.plist`
* [ ] `cd /var` ==> `mkdir mysql` ==> `sudo ln -s /tmp/mysql.sock`
* [ ] Add `/usr/local/bin/bash` to `/etc/shells` then `chsh -s /usr/local/bin/bash`

## Installation

### Using Git and the bootstrap script

Clone this repository in `~/Projects`. The bootstrapper script will pull in the latest version and symlink the files to your home folder.

```bash
git clone https://github.com/julienbourdeau/dotfiles.git && cd dotfiles && bash symlink-dotfiles.sh
```


### Add custom commands without creating a new fork

If `~/.extra` exists, it will be sourced along with the other files. You can use this to add a few custom commands without the need to fork this entire repository, or to add commands you don’t want to commit to a public repository.


### Install Homebrew formulas

Install [Homebrew](http://brew.sh/)

```bash
./etc/brew.sh
./etc/cask.sh
```

##### Note

Compare from 1d6664ec420ff19dae837def525f1b7af1cef8f6 ==> https://github.com/mathiasbynens/dotfiles/compare/1d6664ec420ff19dae837def525f1b7af1cef8f6...master

## Thanks to…

* [@mathiasbynens](https://github.com/mathiasbynens/dotfiles/)
* [@paulmillr](https://github.com/paulmillr/dotfiles/)
* [@statico](https://github.com/statico/dotfiles/)
