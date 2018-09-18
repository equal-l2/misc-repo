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
compinit

autoload -U zmv
bindkey -e

export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export EDITOR=nvim
export MANPAGER="nvim -c 'set ft=man' -"
alias ls='exa -aFs Extension'
export PATH=~/clogsys:~/bin:/usr/local/sbin:/usr/local/opt/texinfo/bin:~/go/bin:/opt/metasploit-framework/bin/:$PATH
export RUST_BACKTRACE=1
export RUSTFLAGS='-C linker=rust-lld -Z linker-flavor=ld64.lld'
export RUST_SRC_PATH=~/.rustup/toolchains/nightly-x86_64-apple-darwin/lib/rustlib/src/rust/src
export JAVA_HOME=`/usr/libexec/java_home`
PS1=$'
\e[7m[ %~ : \e[3%(?.2.1)mStatus %?\e[39m%1(j. : Job%2(j.s.) %j.) ]\e[m
%# '

eval "$(thefuck --alias fixit)"
[[ $- != *i* ]] && return
[[ -n "$TMUX" ]] || exec tmux
