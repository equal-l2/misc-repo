HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
zstyle ':completion:*' completer _complete
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' use-cache true
zstyle :compinstall filename '~/.zshrc'
setopt magic_equal_subst
setopt glob_dots
setopt auto_pushd
setopt pushd_to_home
setopt list_packed

autoload -Uz compinit
fpath+=~/.zfunc
fpath+=/usr/local/share/zsh/site-functions
compinit

autoload -U zmv
bindkey -e

alias ls='ls -AFG'
export BAT_STYLE='plain'
export BAT_THEME='zenburn'
export EDITOR=nvim
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export MANPAGER="nvim -c 'set ft=man' -"
export PATH=~/bin:/usr/local/sbin:/usr/local/opt/texinfo/bin:$PATH
export RUST_BACKTRACE=1
export JAVA_HOME=`/usr/libexec/java_home`


if [ -n "$SSH_CONNECTION" ]; then
    SERVER_IP=${${(z)SSH_CONNECTION}[3]}
    PROMPT_BEFORE=$'\n\e[7m< SSH : '$SERVER_IP$' >\e[m'
fi

PS1=$PROMPT_BEFORE$'\n\e[7m[ %~ : \e[3%(?.2.1)mStatus %?\e[39m%1(j. : Job%2(j.s.) %j.) ]\e[m\n%# '
function daily-update {
    brew upgrade --fetch-HEAD

    brew cask upgrade --greedy

    rustup update --force
    cargo install-update -a

    pip3 list --outdated --format=columns
    npm up -g
}

source <(antibody init)
antibody bundle <<- EOF
zsh-users/zsh-completions
zdharma/fast-syntax-highlighting
EOF

test -r ~/.opam/opam-init/init.zsh && . ~/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true
