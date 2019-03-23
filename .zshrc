source ~/.zplug/init.zsh

zplug 'zplug/zplug', hook-build:'zplug --self-manage'
zplug 'zsh-users/zsh-completions'
zplug 'zdharma/fast-syntax-highlighting', defer:2

zplug load

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
PS1=$'
\e[7m[ %~ : \e[3%(?.2.1)mStatus %?\e[39m%1(j. : Job%2(j.s.) %j.) ]\e[m
%# '

function daily-update {
    brew upgrade --fetch-HEAD

    brew cask upgrade --greedy

    rustup update
    cargo install-update -a

    pip3 list --outdated --format=columns
    npm up -g
}
