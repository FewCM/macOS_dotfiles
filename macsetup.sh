#!/usr/bin/env bash

set -e

# ANSI colors for output
YELLOW="\033[0;33m"
NC="\033[0m"

# Function to apply macOS tweaks
function apply_macos_tweaks() {
    echo -e "${YELLOW}Applying macOS system tweaks...${NC}"

    
    ###############################################################################
    # Dock preferences                                                            #
    ###############################################################################
    # Don't show recently used applications in the Dock
    defaults write com.Apple.Dock show-recents -bool false
    # autohide dock
    defaults write com.apple.dock autohide -bool true
    # autohide-delay
    defaults write com.apple.dock autohide-delay -float 0
    defaults write com.apple.dock autohide-time-modifier -float 0
    # Dock hot corners
    # Possible values:
    #  0: no-op
    #  2: Mission Control
    #  3: Show application windows
    #  4: Desktop
    #  5: Start screen saver
    #  6: Disable screen saver
    #  7: Dashboard
    # 10: Put display to sleep
    # 11: Launchpad
    # 12: Notification Center
    # 13: Lock Screen
    # 14: Quick note
    # Hot corners
    # Top left screen corner → Desktop
    defaults write com.apple.dock wvous-tl-corner -int 4
    defaults write com.apple.dock wvous-tl-modifier -int 0
    # Top right screen corner → Launchpad
    defaults write com.apple.dock wvous-tr-corner -int 11
    defaults write com.apple.dock wvous-tr-modifier -int 0
    # Bottom left screen corner → Start screen saver
    #defaults write com.apple.dock wvous-bl-corner -int 5
    #defaults write com.apple.dock wvous-bl-modifier -int 0


    ###############################################################################
    # Software update preferences                                                 #
    ###############################################################################
    # Enable the automatic update check
    defaults write com.apple.SoftwareUpdate AutomaticCheckEnabled -bool true
    # Check for software updates daily, not just once per week
    defaults write com.apple.SoftwareUpdate ScheduleFrequency -int 1  # Daily updates
    # Download newly available updates in background
    defaults write com.apple.SoftwareUpdate AutomaticDownload -bool true
    # Install System data files & security updates
    defaults write com.apple.SoftwareUpdate CriticalUpdateInstall -bool true
    # Turn off app auto-update
    defaults write com.apple.commerce AutoUpdate -bool false

    ###############################################################################
    # Finder preferences                                                          #
    ###############################################################################
    # Show icons for hard drives, servers, and removable media on the desktop
    defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true
    defaults write com.apple.finder ShowHardDrivesOnDesktop -bool true
    defaults write com.apple.finder ShowMountedServersOnDesktop -bool true
    defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true
    # show hidden files by default
    defaults write com.apple.finder AppleShowAllFiles -bool true
    # show all filename extensions
    defaults write NSGlobalDomain AppleShowAllExtensions -bool true
    # show show status bar
    defaults write com.apple.finder ShowStatusBar -bool true
    # show path bar
    defaults write com.apple.finder ShowPathbar -bool true
    # Display full POSIX path as Finder window title
    defaults write com.apple.finder _FXShowPosixPathInTitle -bool true
    # Keep folders on top when sorting by name
    defaults write com.apple.finder _FXSortFoldersFirst -bool true
    # When performing a search, search the current folder by default
    defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"
    # Disable the warning when changing a file extension
    defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false
    # Avoid creating .DS_Store files on network or USB volumes
    defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
    defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true
    # Use list view in all Finder windows by default
    # Four-letter codes for the other view modes: `icnv`, `clmv`, `glyv`
    defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"
    # Disable the warning before emptying the Trash
    defaults write com.apple.finder WarnOnEmptyTrash -bool false
    # Disable the 'Are you sure you want to open this application?' dialog
    defaults write com.apple.LaunchServices LSQuarantine -bool false
    # Disable auto-correct
    defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

    # Restart affected apps
    echo -e "${YELLOW}Restarting affected apps...${NC}"
    for app in "Activity Monitor" "Calendar" "cfprefsd" "Dock" "Finder" "Mail" "Photos" "Safari" "SystemUIServer"; do
        killall "$app" &>/dev/null || true
    done
}

# Function to ensure Homebrew is installed
function ensure_homebrew() {
    echo -e "${YELLOW}Checking Homebrew installation...${NC}"

    if ! command -v brew &>/dev/null; then
        echo "Homebrew is not installed. Attempting to install..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" || {
            echo "Error: Homebrew installation failed." >&2
            exit 1
        }
    else
        echo "Homebrew is already installed."
    fi
}

# Main script execution
apply_macos_tweaks
ensure_homebrew

echo -e "${YELLOW}All done! Some changes may require a logout or restart to take effect.${NC}"
