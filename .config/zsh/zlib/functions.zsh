#!/usr/bin/env zsh

system_update() {
    local NC="\033[0m"
    local YELLOW="\033[0;33m"

    # Homebrew
    echo -e "${YELLOW}Updating Homebrew formulae and casks...${NC}"
    if ! brew update && brew upgrade; then
        echo "Error: Homebrew update or upgrade failed." >&2
        return 1
    fi

    # Avoid annoying `(latest) != latest` cask updates:
    # shellcheck disable=SC2046
    brew upgrade $(brew outdated --greedy --verbose | awk '$2 !~ /(latest)/ {print $1}')
    brew cleanup --prune=all 

    # Ensure the Brew config directory and Brewfile exist
    if [ ! -d "$HOME/.config/Brew" ]; then
        echo "Creating Brew folder in .config" >&2
        mkdir -p "$HOME/.config/Brew"
    fi
    if [ ! -f "$HOME/.config/Brew/Brewfile" ]; then
        touch "$HOME/.config/Brew/Brewfile"
        echo "Brewfile created in .config/Brew" >&2
    else
        echo "Brewfile updated" >&2
    fi
    brew bundle dump --force --file "$HOME/.config/Brew/Brewfile"

    # App Store
    echo -e "${YELLOW}Checking for App Store updates...${NC}"
    mas outdated

     # macOS system
     echo -e "${YELLOW}Checking for macOS system updates...${NC}"
     softwareupdate --list

    # Zinit & plugins
    echo -e "${YELLOW}Updating zinit...${NC}"
    if ! zinit self-update || ! zinit update --all; then
        echo "Error: Zinit update failed." >&2
        return 1
    fi
}

brew() {
    # Ensure the Brew config directory and Brewfile exist
    ensure_brewfile() {
        if [ ! -d "$HOME/.config/Brew" ]; then
            echo "Creating Brew folder in .config" >&2
            mkdir -p "$HOME/.config/Brew"
        fi
        if [ ! -f "$HOME/.config/Brew/Brewfile" ]; then
            touch "$HOME/.config/Brew/Brewfile"
            echo "Brewfile created in .config/Brew" >&2
        else
            echo "Brewfile updated" >&2
        fi
    }

    # Handle the custom "add" argument
    if [[ $1 == "add" ]]; then
        shift
        command brew install "$@"
        ensure_brewfile
        brew bundle dump --force --file "$HOME/.config/Brew/Brewfile"

    # Handle the custom "minus" argument
    elif [[ $1 == "minus" ]]; then
        shift
        command brew uninstall "$@"
        ensure_brewfile
        brew bundle dump --force --file "$HOME/.config/Brew/Brewfile"

    # Default behavior for other brew commands
    else
        command brew "$@"
    fi
}

timezsh() {
    local shell=${1:-$SHELL}
    for i in $(seq 1 10); do
        /usr/bin/time "$shell" -i -c exit
    done
}
