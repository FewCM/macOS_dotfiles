#setopt COMPLETE_ALIASES
setopt nonomatch
setopt interactive_comments
setopt correct
setopt no_correct_all          # don't try to correct the spelling of all arguments in a line
setopt noclobber
setopt complete_aliases
setopt HIST_SAVE_NO_DUPS
setopt HIST_IGNORE_DUPS
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_ALL_DUPS
setopt SHARE_HISTORY
setopt INC_APPEND_HISTORY
setopt EXTENDED_GLOB # treat special characters as part of patterns
setopt glob_dots               # include dotfiles when globbing
setopt NO_FLOW_CONTROL # disable stupid annoying keys
setopt AUTO_CD # if the command is directory and cannot be executed, perfort cd to this directory
setopt auto_pushd              # make cd push the old directory onto the directory stack
setopt CLOBBER # allow > redirection to truncate existing files
setopt BRACE_CCL # allow brace character class list expansion
setopt NO_BEEP # do not beep on errors
setopt NO_NOMATCH # try to avoid the 'zsh: no matches found...'
setopt COMPLETE_IN_WORD # allow completion from within a word/phrase
setopt LONG_LIST_JOBS # list jobs in the long format by default
setopt AUTO_RESUME # attempt to resume existing job before creating a new process
setopt NOTIFY # report status of background jobs immediately
setopt auto_list
setopt auto_menu
setopt no_menu_complete        # don't autoselect the first completion entry
setopt prompt_subst           # expand parameters in prompt variables
