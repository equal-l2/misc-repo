HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000

zstyle ':completion:*' completer _complete
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' matcher-list 'm:{[:lower:]}={[:upper:]}'
zstyle ':completion:*' use-cache true
zstyle :compinstall filename '~/.zshrc'

setopt magic_equal_subst
setopt glob_dots
setopt auto_pushd
setopt pushd_to_home
setopt list_packed

fpath+=/usr/local/share/zsh/site-functions
fpath+=/usr/local/share/zsh-completions
fpath+=~/.zfunc
autoload -Uz compinit
compinit

autoload -U zmv
bindkey -e

alias ls='uls --color=auto --classify=auto -A'
export VOLTA_HOME=$HOME/.volta
export EDITOR=nvim
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export MANPAGER='nvim +Man!'
export PATH=$VOLTA_HOME/bin:~/bin:/usr/local/sbin:/usr/local/opt/texinfo/bin:$PATH
export RUST_BACKTRACE=1

export HOMEBREW_BAT=1
export HOMEBREW_DEVELOPER=1
export HOMEBREW_EVAL_ALL=1
export HOMEBREW_NO_COMPAT=1

# prompt
setopt prompt_subst
precmd() {
    # set git branch name to _git_br
    local out; # NB `local` is a command, which mutate $?
    out=$(git symbolic-ref --short -q HEAD 2>/dev/null)
    local cmdst=$?
    if [ $cmdst -eq 0 ]; then
        _git_br=$' @ '$out
    elif [ $cmdst -eq 1 ]; then
        _git_br=$' @ \e[41m?\e[49m'
    else
        _git_br=$''
    fi
}

if [ -n "$SSH_CONNECTION" ]; then
    SERVER_IP=${${(z)SSH_CONNECTION}[3]}
    PROMPT_BEFORE=$'\n\e[7m< SSH : '$SERVER_IP$' >\e[m'
fi

PS1=$PROMPT_BEFORE$'\n\e[7m[ %~$_git_br : \e[3%(?.2.1)mStatus %?\e[39m%1(j. : Job%2(j.s.) %j.) ]\e[m\n%# '

typeset -A ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[globbing]='fg=cyan'
ZSH_HIGHLIGHT_STYLES[history-expansion]='fg=cyan'

function daily-update {
    brew upgrade --fetch-HEAD --greedy

    rustup update
    cargo install-update -a

    npm up -g
}

. /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

eval "$(direnv hook zsh)"

# The next line updates PATH for the Google Cloud SDK.
if [ -f ~/google-cloud-sdk/path.zsh.inc ]; then
    . ~/google-cloud-sdk/path.zsh.inc
fi

# The next line enables shell command completion for gcloud.
if [ -f ~/google-cloud-sdk/completion.zsh.inc ]; then
    . ~/google-cloud-sdk/completion.zsh.inc
fi
