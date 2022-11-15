# Julien’s dotfiles

```
$ ./dot
Usage:
./dot [--dotfiles] [--sublime] [--mackup] [--hosts] [--homebrew-bash] [--php]

Options:
   -d | --dotfiles    Symlink dotfiles in home/ directory
   -h | --hosts       Create local hosts files and symlink it
   --php              Setup php prepended file
   --sublime          Symlink Sublime Text preferences
   --homebrew-bash    Add bash from homebrew to shell login and switch to it

```



## Install new mac


### Install all the things

```sh
./macos/00-brew.sh
./macos/01-basic.sh
./macos/02-apps.sh
./macos/03-lang.sh
```

### Link configuration

```sh
./dot --dotfiles
./dot --homebrew-bash
./dot --sublime
./dot --php
```

`./dot --dotfiles` can be executed anytime.

Configure iTerm to use `misc/terminal`.

![](https://user-images.githubusercontent.com/1525636/201951710-1df49a04-7600-4e53-8bec-d0c4cbe0fe0c.png)

## Thanks to…

* [@mathiasbynens](https://github.com/mathiasbynens/dotfiles/) ([compare](https://github.com/mathiasbynens/dotfiles/compare/d6ca39a907123c0a7f874c500ba16cabb3156a63...master))
* [@paulmillr](https://github.com/paulmillr/dotfiles/) ([for vim config](https://github.com/paulmillr/vimrc/tree/5b472316d099fc1f6626ca790e81f6d021747c13) **NEEDS UPDATE**) 
* [@statico](https://github.com/statico/dotfiles/)
