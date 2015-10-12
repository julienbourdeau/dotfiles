# Julien’s dotfiles

## TODO

* [ ] Clean aliases
* [x] sudo ln -s ~/Projects/dotfiles/etc/hosts /etc/hosts
* [ ] cp /Users/julien/Projects/dotfiles2/sublime/Sublime\ Text.icns /Applications/Sublime\ Text.app/Contents/Resources/Sublime\ Text.icns
* [ ] Compare from 1d6664ec420ff19dae837def525f1b7af1cef8f6 ==> https://github.com/mathiasbynens/dotfiles/compare/1d6664ec420ff19dae837def525f1b7af1cef8f6...master

* [ ] Create locate database `sudo launchctl load -w /System/Library/LaunchDaemons/com.apple.locate.plist`
* [ ] `cd /var` ==> `mkdir mysql` ==> `sudo ln -s /tmp/mysql.sock`

## Installation

### Using Git and the bootstrap script

You can clone the repository wherever you want. (I like to keep it in `~/Projects/dotfiles`, with `~/dotfiles` as a symlink.) The bootstrapper script will pull in the latest version and copy the files to your home folder.

```bash
git clone https://github.com/julienbourdeau/dotfiles.git && cd dotfiles && bash symlink-dotfiles.sh
```


### Specify the `$PATH`

If `~/.path` exists, it will be sourced along with the other files, before any feature testing (such as [detecting which version of `ls` is being used](https://github.com/mathiasbynens/dotfiles/blob/aff769fd75225d8f2e481185a71d5e05b76002dc/.aliases#L21-26)) takes place.

Here’s an example `~/.path` file that adds `/usr/local/bin` to the `$PATH`:

```bash
export PATH="/usr/local/bin:$PATH"
```

### Add custom commands without creating a new fork

If `~/.extra` exists, it will be sourced along with the other files. You can use this to add a few custom commands without the need to fork this entire repository, or to add commands you don’t want to commit to a public repository.

### Sensible OS X defaults

When setting up a new Mac, you may want to set some sensible OS X defaults:

```bash
./etc/osx.sh
```

### Install Homebrew formulae

When setting up a new Mac, you may want to install some common [Homebrew](http://brew.sh/) formulae (after installing Homebrew, of course):

```bash
./etc/brew.sh
```

## Author

| [![twitter/julienbourdeau](https://fr.gravatar.com/userimage/3005984/cd8b7ee07c77f54aa2c999055fcd4566.jpeg)](http://twitter.com/julienbourdaeu "Follow @julienbourdeau on Twitter") |
|---|
| [Julien Bourdeau](https://www.julienbourdeau.com/) |

## Thanks to…

* [@mathiasbynens](https://github.com/mathiasbynens/dotfiles/)
* [@paulmillr](https://github.com/paulmillr/dotfiles/)
* [@statico](https://github.com/statico/dotfiles/)
