#!/bin/zsh

# Zinit Profiling (optional for debugging slow startup)
zmodload zsh/zprof 
export GPG_TTY=$TTY

### Zinit installation (if not already installed)
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} Installing Zinit Plugin Manager...%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" || print -P "%F{160} Installation failed.%f"
fi
source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"

# Auto-Load Zinit Modules
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit
module_path+=( "/home/fewcm/.local/share/zinit/module/Src" )
zmodload zdharma_continuum/zinit &>/dev/null

# Plugin loading with Zinit (light and ice syntax)
zinit light-mode for \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-submods \
    NICHOLAS85/z-a-linkman \
    NICHOLAS85/z-a-linkbin

#typeset -F4 SECONDS=0

# Core plugins and binaries (with delay loading)
#zinit ice wait lucid multisrc "alias.zsh zopts.zsh"
#zinit light $ZDOTDIR/zlib



# Delta and fd binaries with delayed loading (from GitHub releases)
zinit ice from"gh-r" as"command" \
    mv"delta-*/delta -> delta" \
    dl"https://github.com/dandavison/delta/raw/HEAD/etc/completion/completion.zsh -> _delta" \
    atload'export DELTA_PAGER="less -R -F -+X --mouse"' 
zinit light dandavison/delta

zinit ice from"gh-r" as"command" \
    mv"fd-*/fd -> fd" \
    atclone"mv -vf fd-*/autocomplete/_fd _fd; mv -vf fd-*/fd.1 ${ZINIT[MAN_DIR]}/man1" \
    atload'export FZF_FD_OPTS="--color always --hidden --follow --exclude .git --exclude node_modules"'
zinit light sharkdp/fd

# Colors and LS_COLORS setup
zinit ice atclone"dircolors -b LS_COLORS > clrs.zsh" \
    atpull'%atclone' pick"clrs.zsh" nocompile'!' \
    atload'zstyle ":completion:*" list-colors “${(s.:.)LS_COLORS}”'
zinit light trapd00r/LS_COLORS

zinit ice wait'1a' lucid  atload'bindkey "^d" dotbare-fedit' 
zinit light kazhala/dotbare

# Zsh completions and syntax highlighting
zinit ice wait'0a' blockf lucid atpull'zinit creinstall -q .' 
zinit light zsh-users/zsh-completions

# Diff-so-fancy plugin (delayed loading)
# zinit ice wait"2" lucid as"program" pick"bin/git-dsf"
# zinit load zdharma-continuum/zsh-diff-so-fancy

# FZF binary and keybindings
zinit ice from"gh-r" as"command" \
    dl"https://github.com/junegunn/fzf/raw/HEAD/shell/key-bindings.zsh -> key-bindings.zsh" \
    dl"https://github.com/junegunn/fzf/raw/HEAD/shell/completion.zsh -> _fzf" \
    dl"https://github.com/junegunn/fzf/raw/HEAD/man/man1/fzf.1 -> ${ZINIT[MAN_DIR]}/man1/fzf.1" \
    dl"https://github.com/junegunn/fzf/raw/HEAD/man/man1/fzf-tmux.1 -> ${ZINIT[MAN_DIR]}/man1/fzf-tmux.1" \
    src"key-bindings.zsh" 
zinit light junegunn/fzf
source $ZDOTDIR/zlib/fzf.zsh

# History substring search (delayed load)
_zsh-history-substring-search-setting() {
HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND='bg=green,fg=white'
HISTORY_SUBSTRING_SEARCH_FUZZY=1
bindkey "${key[Up]}"   history-substring-search-up
bindkey "${key[Down]}" history-substring-search-down
bindkey "^[[A" history-substring-search-up
bindkey "^[[B" history-substring-search-down
bindkey "$terminfo[kcuu1]" history-substring-search-up
bindkey "$terminfo[kcud1]" history-substring-search-down
}
zinit ice wait'0b' atload'!_zsh-history-substring-search-setting' lucid
zinit light zsh-users/zsh-history-substring-search

# Autosuggestions settings and plugin load
# _zsh_autosuggest_setting() {
#     ZSH_AUTOSUGGEST_ACCEPT_WIDGETS=("${(@)ZSH_AUTOSUGGEST_ACCEPT_WIDGETS:#forward-char}")
#     ZSH_AUTOSUGGEST_PARTIAL_ACCEPT_WIDGETS+=(forward-char)
#     bindkey '^[[C' forward-word
#     bindkey "${terminfo[kcuf1]}" forward-word
#     ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
#     ZSH_AUTOSUGGEST_HISTORY_IGNORE="?(#c50,)"
#     ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=orange"
#     ZSH_AUTOSUGGEST_USE_ASYNC=true
#     ZSH_AUTOSUGGEST_COMPLETION_IGNORE="[[:space:]]*"
# }
# zinit ice wait'0a' atload'!_zsh_autosuggest_start; _zsh_autosuggest_setting' lucid
# zinit light zsh-users/zsh-autosuggestions

zinit ice wait'0a' lucid
zinit light zsh-users/zsh-autosuggestions

# Per-directory history settings
# _per-directory-history-settings() {
#     export PER_DIRECTORY_HISTORY_BASE=$ZDOTDIR/.zsh_history_dirs
# }
# zinit wait'2' lucid atinit"export HISTORY_START_WITH_GLOBAL=true ; _per-directory-history-settings" atload"_per-directory-history-set-global-history" light-mode for @CyberShadow/per-directory-history

# FZF tab completion
# zinit ice wait"1" lucid has"fzf" atload"
#     zstyle ':completion:*' verbose yes
#     zstyle ':completion:*' list-colors \${(s.:.)LS_COLORS}
#     zstyle ':completion:*:descriptions' format '[%d]'
#     zstyle ':completion::complete:*:*:files' ignored-patterns '.DS_Store' 'Icon?' '.Trash'
#     zstyle ':completion::complete:rm:*:globbed-files' ignored-patterns
#     zstyle ':fzf-tab:*' fzf-command fzf
#     zstyle ':fzf-tab:*' fzf-flags '--ansi'
# "
# zinit light Aloxaf/fzf-tab

# Syntax highlighting (with Zinit loading)
zinit ice depth'1' lucid wait'0'  atinit"ZINIT[COMPINIT_OPTS]=-C; zicompinit; zicdreplay"
zinit light zdharma-continuum/fast-syntax-highlighting 

# Starship prompt (with delayed load)
zinit ice from"gh-r" as"command" atload'eval "$(starship init zsh)" > /dev/null 2>&1 ; export STARSHIP_CONFIG=~/.config/starship/config.toml'
zinit load starship/starship

# Final timing report
# print "[zshrc] ZSH took ${(M)$(( SECONDS * 1000 ))#*.?} ms"

# Homebrew & Python path setup
# function eval_homebrew() {
#     if command -v brew &>/dev/null; then
#         eval "$(/opt/homebrew/bin/brew shellenv)"
#         FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
#     fi
# }

# function add_python_path() {
#     if command -v python &>/dev/null; then
#         export PATH="$(brew --prefix python)/libexec/bin:$PATH"
#     fi
# }

# eval_homebrew
# add_python_path

# eval "$(/opt/homebrew/bin/brew shellenv)"
# export PATH="$(brew --prefix python)/libexec/bin:$PATH"

# eval_homebrew
#eval "$(/opt/homebrew/bin/brew shellenv)"
export HOMEBREW_PREFIX="/opt/homebrew";
export HOMEBREW_CELLAR="/opt/homebrew/Cellar";
export HOMEBREW_REPOSITORY="/opt/homebrew";
export PATH="/opt/homebrew/bin:/opt/homebrew/sbin${PATH+:$PATH}";
export MANPATH="/opt/homebrew/share/man${MANPATH+:$MANPATH}:";
export INFOPATH="/opt/homebrew/share/info:${INFOPATH:-}";

export FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
export PATH="$(brew --prefix python)/libexec/bin:$PATH"

source $ZDOTDIR/zlib/functions.zsh
source $ZDOTDIR/zlib/alias.zsh
source $ZDOTDIR/zlib/zopts.zsh