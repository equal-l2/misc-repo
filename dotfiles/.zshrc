zstyle ':completion:*' list-colors ''
fpath+=/usr/local/share/zsh/site-functions
fpath+=/usr/local/share/zsh-completions
fpath+=~/.zfunc
autoload -Uz compinit
compinit

alias ls='uls --color=auto --classify=auto -A'
export VOLTA_HOME=$HOME/.volta
export EDITOR=nvim
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
        # show branch name
        _git_br=$' @ '$out
    elif [ $cmdst -eq 1 ]; then
        # no symbolic ref, show a red "?"
        _git_br=$' @ \e[41m?\e[49m'
    else
        # the other errors, assuming the pwd is not a git repo
        # show nothing
        _git_br=$''
    fi
}

PS1=$'\n\e[7m[ %~$_git_br : \e[3%(?.2.1)mStatus %?\e[39m%1(j. : Job%2(j.s.) %j.) ]\e[m\n%# '

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
