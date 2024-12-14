#!/usr/bin/env zsh

alias ~="cd ~"
alias finder="open -a Finder ."

#### EZA   ####
alias ls='eza --color=auto -GF --icons --group-directories-first'
alias ll='eza --color=auto -1laF --git --icons --group-directories-first --ignore-glob=".DS_Store*|~*"'
alias lt='ll -T -L=2'

alias speedtest="curl -s https://raw.githubusercontent.com/sivel/speedtest-cli/master/speedtest.py | python -"
alias reload="exec zsh"
#alias config='/usr/bin/git --git-dir=$HOME/dotfiles/ --work-tree=$HOME'
