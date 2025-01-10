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

typeset -F4 SECONDS=0

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
# source $ZDOTDIR/zlib/fzf.zsh

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

# Syntax highlighting (with Zinit loading)
zinit ice depth'1' lucid wait'0'  atinit"ZINIT[COMPINIT_OPTS]=-C; zicompinit; zicdreplay"
zinit light zdharma-continuum/fast-syntax-highlighting 

# Starship prompt (with delayed load)
zinit ice from"gh-r" as"command" atload'eval "$(starship init zsh)" > /dev/null 2>&1 ; export STARSHIP_CONFIG=~/.config/starship/config.toml'
zinit load starship/starship

# zinit light Aloxaf/fzf-tab

# # disable sort when completing `git checkout`
# zstyle ':completion:*:git-checkout:*' sort false
# # set descriptions format to enable group support
# # NOTE: don't use escape sequences (like '%F{red}%d%f') here, fzf-tab will ignore them
# zstyle ':completion:*:descriptions' format '[%d]'
# # set list-colors to enable filename colorizing
# zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
# # force zsh not to show completion menu, which allows fzf-tab to capture the unambiguous prefix
# zstyle ':completion:*' menu no
# # preview directory's content with eza when completing cd
# zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always $realpath'
# # custom fzf flags
# # NOTE: fzf-tab does not follow FZF_DEFAULT_OPTS by default
# zstyle ':fzf-tab:*' fzf-flags --color=fg:1,fg+:2 --bind=tab:accept
# # To make fzf-tab follow FZF_DEFAULT_OPTS.
# # NOTE: This may lead to unexpected behavior since some flags break this plugin. See Aloxaf/fzf-tab#455.
# zstyle ':fzf-tab:*' use-fzf-default-opts yes
# # switch group using `<` and `>`
# zstyle ':fzf-tab:*' switch-group '<' '>'

# tab completions via fzf
zinit ice wait"1" lucid \
  has"fzf" \
  atload"
    zstyle ':completion:*' verbose yes
    zstyle ':completion:*' list-colors \${(s.:.)LS_COLORS}
    zstyle ':completion:*:descriptions' format '[%d]'
    zstyle ':completion::complete:*:*:files' ignored-patterns '.DS_Store' 'Icon?' '.Trash'
    zstyle ':completion::complete:*:*:globbed-files' ignored-patterns '.DS_Store' 'Icon?' '.Trash'
    zstyle ':completion::complete:rm:*:globbed-files' ignored-patterns
    zstyle ':fzf-tab:*' fzf-command fzf
    zstyle ':fzf-tab:*' fzf-flags '--ansi'
    zstyle ':fzf-tab:*' fzf-bindings \
      'tab:accept' \
      'ctrl-y:preview-page-up' \
      'ctrl-v:preview-page-down' \
      'ctrl-e:execute-silent(\${VISUAL:-code} \$realpath >/dev/null 2>&1)' \
      'ctrl-w:execute(\${EDITOR:-nano} \$realpath >/dev/tty </dev/tty)+refresh-preview'
    zstyle ':fzf-tab:*' fzf-min-height 15
    zstyle ':fzf-tab:complete:git-(add|diff|restore):*' fzf-preview \
      'git diff --no-ext-diff \$word | delta --paging=never --no-gitconfig --line-numbers --file-style=omit --hunk-header-style=omit --theme=base16'
    zstyle ':fzf-tab:complete:git-log:*' fzf-preview \
      'git --no-pager log --color=always --format=oneline --abbrev-commit --follow \$word'
    zstyle ':fzf-tab:complete:man:*' fzf-preview \
      'man -P \"col -bx\" \$word | $FZF_PREVIEW_FILE_COMMAND --language=man'
    zstyle ':fzf-tab:complete:brew-(install|uninstall|search|info):*-argument-rest' fzf-preview \
      'brew info \$word'
    zstyle ':fzf-tab:complete:(-command-|-parameter-|-brace-parameter-|export|unset|expand):*' fzf-preview \
      'echo \${(P)word}'
    zstyle ':fzf-tab:complete:*:options' fzf-preview
    zstyle ':fzf-tab:complete:*:options' fzf-flags '--no-preview'
    zstyle ':fzf-tab:complete:*:argument-1' fzf-preview
    zstyle ':fzf-tab:complete:*:argument-1' fzf-flags '--no-preview'
    zstyle ':fzf-tab:complete:*:*' fzf-preview \
      '($FZF_PREVIEW_FILE_COMMAND \$realpath || $FZF_PREVIEW_DIR_COMMAND \$realpath) 2>/dev/null'
  "
zinit light Aloxaf/fzf-tab

# Final timing report
print "[zshrc] ZSH took ${(M)$(( SECONDS * 1000 ))#*.?} ms"

source $ZDOTDIR/zlib/functions.zsh
source $ZDOTDIR/zlib/alias.zsh
source $ZDOTDIR/zlib/zopts.zsh