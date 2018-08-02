source ~/.zplug/init.zsh

zplug 'zplug/zplug', hook-build:'zplug --self-manage'
zplug 'zsh-users/zsh-completions'
zplug 'zdharma/fast-syntax-highlighting', defer:2
zplug 'Tarrasch/zsh-bd'

zplug load

HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
zstyle ':completion:*' completer _complete _correct _approximate
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' use-cache true
zstyle :compinstall filename '~/.zshrc'
setopt magic_equal_subst
setopt glob_dots

autoload -Uz compinit
fpath+=~/.zfunc
compinit

autoload -U zmv
setopt correct

export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export EDITOR=nvim
export MANPAGER="nvim -c 'set ft=man' -"
alias ls='exa -aFs Extension'
export PATH=~/clogsys:~/bin:/usr/local/sbin:/usr/local/opt/texinfo/bin:~/go/bin:/opt/metasploit-framework/bin/:$PATH
export RUST_BACKTRACE=1
export RUST_SRC_PATH=~/.rustup/toolchains/nightly-x86_64-apple-darwin/lib/rustlib/src/rust/src
export JAVA_HOME=`/usr/libexec/java_home`
PROMPT=$'
%{\e[7m%}[ %~ : %(?.%{\e[32m%}.%{\e[31m%})Status %?%{\e[0m\e[7m%}%1(j. : Job(s) %j.) ]%{\e[0m%}
%# '

if brew command command-not-found-init > /dev/null 2>&1; then eval "$(brew command-not-found-init)"; fi
