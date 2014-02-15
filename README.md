dotfiles
========

```
                          _                                
      __     _ _         | |        _____         ___ _     
   __|  |_ _| |_|___ ___ |_| ___   |     |___ ___|  _|_|___ 
  |  |  | | | | | -_|   |   |_ -|  |   --| . |   |  _| | . |
  |_____|___|_|_|___|_|_|   |___|  |_____|___|_|_|_| |_|_  |
                                                       |___|
```


This repository keeps all my Mac configuration. Most of it will work on Linux but I encountered some issues (see Known issues). Those files are mostly based on [Ian's project](https://github.com/statico/dotfiles) and [Paul's project](https://github.com/paulmillr/dotfiles).

## How it works

Basically, all your configuration files (.zshrc, .vimrc,...) will be in *~/Projects/dotfiles* (you can change the folder) and they will be symlinked in your home directory. Then every time you modify anything you can version control it with Git and Github.

## Install

First you need to clone this repository or download the [zipball](https://github.com/julienbourdeau/dotfiles/archive/master.zip).

Then change few options to make it this YOURS.

### .gitconfig.base

Change at least line 5 and 6

```
[user]
	name = John Doe
	email = youremail@address.com
```

### install.sh

You may want to change the first few lines:
```
basedir=$HOME/Projects/dotfiles
bindir=$HOME/bin
gitbase=git@github.com:julienbourdeau/dotfiles.git
tarball=http://github.com/julienbourdeau/dotfiles/tarball/master
```

### Install Prezto and switch to zsh

To get everything to work nicely you will need Prezto (a configuration framework for Zsh).
```
git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
```
Then switch to zsh
```
chsh -s /bin/zsh
```

After you switched, restart your terminal and launch the install
```
sh install.sh
```

## OS X specific config

### osx.sh 

This script will setup your mac the way you like (I mean the way I like). So you should go through it before executing it. It's based on [Mathias' famous script](https://github.com/mathiasbynens/dotfiles/blob/master/.osx)

At least you need to change, the name of your Mac (starting line 15)

```
#Set computer name (as done via System Preferences → Sharing)
sudo scutil --set ComputerName "Julien's MBA"
sudo scutil --set HostName "Julien's MBA"
sudo scutil --set LocalHostName "juliens-mba"
sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.smb.server NetBIOSName -string "juliens-mba"
```

### brew.sh

[Brew](http://brew.sh/) is the missing package manager for OS X.

This will install software on your computer, check out the etc/brew.sh file to see the list. It also uses Brew Cask to install software like Chrome or VLC.

## Sublime Text config

COMING

use subl
```
ln -s "/Applications/Sublime Text.app/Contents/SharedSupport/bin/subl" ~/bin/subl
```

TODO: Copy paul's stuff according to his files