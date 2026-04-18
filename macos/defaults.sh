#!/usr/bin/env bash
#
# macOS system defaults. Standalone — can be executed directly:
#   ./macos/defaults.sh
#
# Exported from the live system. To refresh a domain:
#   defaults read com.apple.dock
#   defaults read com.apple.AppleMultitouchTrackpad

set -euo pipefail

############################################
## Finder
############################################

defaults write NSGlobalDomain AppleShowAllExtensions -bool true
defaults write com.apple.finder ShowPathbar -bool true
defaults write com.apple.finder ShowStatusBar -bool true
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

############################################
## Save & print panels: expanded by default
############################################

defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true

############################################
## Dock
############################################

defaults write com.apple.dock tilesize -int 32
defaults write com.apple.dock largesize -int 41
defaults write com.apple.dock magnification -bool true
defaults write com.apple.dock minimize-to-application -bool true
defaults write com.apple.dock show-recents -bool false
defaults write com.apple.dock wvous-br-corner -int 1
defaults write com.apple.dock wvous-br-modifier -int 0

############################################
## Trackpad
## Write to both domains so settings apply to built-in and Magic trackpads.
############################################

for d in com.apple.AppleMultitouchTrackpad com.apple.driver.AppleBluetoothMultitouch.trackpad; do
	defaults write "$d" Clicking -bool true
	defaults write "$d" Dragging -bool false
	defaults write "$d" DragLock -bool false
	defaults write "$d" TrackpadThreeFingerDrag -bool false

	defaults write "$d" TrackpadRightClick -bool true
	defaults write "$d" TrackpadCornerSecondaryClick -int 0

	defaults write "$d" TrackpadHorizScroll -bool true
	defaults write "$d" TrackpadScroll -bool true
	defaults write "$d" TrackpadMomentumScroll -bool true
	defaults write "$d" TrackpadPinch -bool true
	defaults write "$d" TrackpadRotate -bool true
	defaults write "$d" TrackpadHandResting -bool true
	defaults write "$d" TrackpadTwoFingerDoubleTapGesture -bool true
	defaults write "$d" TrackpadTwoFingerFromRightEdgeSwipeGesture -int 3
	defaults write "$d" TrackpadThreeFingerTapGesture -int 0
	defaults write "$d" TrackpadThreeFingerHorizSwipeGesture -int 2
	defaults write "$d" TrackpadThreeFingerVertSwipeGesture -int 2
	defaults write "$d" TrackpadFourFingerHorizSwipeGesture -int 2
	defaults write "$d" TrackpadFourFingerVertSwipeGesture -int 2
	defaults write "$d" TrackpadFourFingerPinchGesture -int 2
	defaults write "$d" TrackpadFiveFingerPinchGesture -int 2
	defaults write "$d" USBMouseStopsTrackpad -bool false
done

# Built-in trackpad only: Force Touch click feel.
defaults write com.apple.AppleMultitouchTrackpad ActuateDetents -bool true
defaults write com.apple.AppleMultitouchTrackpad FirstClickThreshold -int 1
defaults write com.apple.AppleMultitouchTrackpad SecondClickThreshold -int 1
defaults write com.apple.AppleMultitouchTrackpad ForceSuppressed -bool false

defaults write NSGlobalDomain com.apple.trackpad.scaling -float 0.875
defaults write NSGlobalDomain com.apple.trackpad.forceClick -bool true

############################################
## Apply
############################################

killall Finder || true
killall Dock || true
