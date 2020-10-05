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

autoload -Uz compinit
fpath+=~/.zfunc
compinit

autoload -U zmv
bindkey -e

#alias ls='ls -AFG'
alias ls='gls -AF --color=auto'
export EDITOR=nvim
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export MANPAGER="nvim -c 'set ft=man' -"
export PATH=~/bin:/usr/local/sbin:/usr/local/opt/texinfo/bin:~/go/bin:$PATH
export RUST_BACKTRACE=1
export RUSTFLAGS="-C target-cpu=native"

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

function daily-update {
    brew upgrade --fetch-HEAD

    brew cask upgrade --greedy

    rustup update
    cargo install-update -a

    #pip3 list --outdated --format=columns
    npm up -g
    antibody update
}

source <(antibody init)
antibody bundle <<- EOF
zsh-users/zsh-completions
zdharma/fast-syntax-highlighting
EOF

if [ "$TERM_PROGRAM" = "iTerm.app" ]; then
    test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
fi

eval "$(zoxide init zsh)"
