#!/bin/zsh

export ZDOTDIR="$HOME/.config/zsh"

# History file configuration
#export HISTFILE="$HOME/.config/zsh/history"
export HISTSIZE=68400
export SAVEHIST=$((HISTSIZE/2))
#HISTORY_IGNORE='([bf]g *|cd ..|l[alsh]#( *)#|less *|vim# *)'
export HISTORY_IGNORE="(ls|pwd|zsh|exit|cd)"
# Corrections
export CORRECT_IGNORE_FILE='.*'

export MANPAGER="sh -c 'col -bx | bat -l man -p'"
export MANROFFOPT="-c"
#export LESS="-R " # colorize output
export LESS="-iRXS --mouse --wheel-lines 2 --status-column --LONG-PROMPT --quit-on-intr --no-histdups"
export LESSHISTFILE=-
# }}}

# LESS (and man) colors{{{2
export LESS_TERMCAP_mb="$(printf '%b' '[1;31m')"     
export LESS_TERMCAP_md="$(printf '%b' '[1;36m')"   
export LESS_TERMCAP_us="$(printf '%b' '[1;32m')"     
export LESS_TERMCAP_so="$(printf '%b' '[01;34;40m')" 
export LESS_TERMCAP_me="$(printf '%b' '[0m')"        
export LESS_TERMCAP_ue="$(printf '%b' '[0m')"        
export LESS_TERMCAP_se="$(printf '%b' '[0m')" 
# }}}

export EZA_ICON_SPACING=1

export BAT_PAGER='less -R -F -+X --mouse'

# # dotbare {{{2
# export DOTBARE_FZF_DEFAULT_OPTS="--preview-window=right:65%"
# export DOTBARE_KEY="
#   --bind=alt-a:toggle-all
#   --bind=alt-w:jump
#   --bind=alt-0:top
#   --bind=alt-s:toggle-sort
#   --bind=alt-t:toggle-preview
# "
# export DOTBARE_PREVIEW="cat -n {}"
# export DOTBARE_DIFF_PAGER="delta --diff-so-fancy --line-numbers"
# # }}}

# # Homebrew & Python path setup
# eval_homebrew() {
#     if command -v brew &>/dev/null; then
#         eval "$(/opt/homebrew/bin/brew shellenv)"
#         FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
#     fi
# }
# #via:
# # Profiling via:
# # https://kev.inburke.com/kevin/profiling-zsh-startup-time/
# : "${PROFILE_STARTUP:=false}"
# : "${PROFILE_ALL:=false}"
# # Run this to get a profile trace and exit: ç zsh -i -c echo
# # Or: time PROFILE_STARTUP=true /bin/zsh -i --login -c echo
# if [[ "$PROFILE_STARTUP" == true || "$PROFILE_ALL" == true ]]; then
#     # http://zsh.sourceforge.net/Doc/Release/Prompt-Expansion.html
#     PS4=$'%D{%H:%M:%S.%.} %N:%i> '
#     #zmodload zsh/datetime
#     #PS4='+$EPOCHREALTIME %N:%i> '
#     exec 3>&2 2>/tmp/zsh_profile.$$
#     setopt xtrace prompt_subst
# fi
# # "unsetopt xtrace" is at the end of ~/.zshrc

