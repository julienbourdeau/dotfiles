#!/bin/bash -e
#
#	This script install everything related to Sublime text
#

basedir=$HOME/Projects/dotfiles
libdir="$HOME/Library/Application Support/Sublime Text 3"
sublbin=/usr/bin/subl

# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until `osx.sh` has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &



echo "Symlinking `subl` bin so you can open Sublime Text from the terminal..."
if [ -f $sublbin ];
then
	rm -rf $sublbin
fi
ln -s /Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl $sublbin

echo "Symlinking your configuration files..."
rm -rf "$libdir"/Packages
rm -rf "$libdir"/Installed\ Packages
ln -s $basedir/sublime/Packages "$libdir"/Packages
ln -s $basedir/sublime/Installed\ Packages "$libdir"/Installed\ Packages

echo "Done !"

exit
