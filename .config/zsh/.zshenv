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



