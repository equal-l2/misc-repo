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
fpath=(/usr/local/share/zsh-completions $fpath)
fpath+=~/.zfunc
compinit

autoload -U zmv
export EDITOR=nvim
alias ls='exa -aF'
export LANG=en_US.UTF-8
export PATH=~/bin:/usr/local/opt/php71/bin:/usr/local/opt/php71/sbin:/usr/local/sbin:/usr/local/opt/texinfo/bin:~/go/bin:$PATH
export RUST_BACKTRACE=1
export RUST_SRC_PATH=~/.rustup/toolchains/nightly-x86_64-apple-darwin/lib/rustlib/src/rust/src
export JAVA_HOME=`/usr/libexec/java_home`
PROMPT=$'
%{\e[7m%}[ %~ : %(?.%{\e[32m%}.%{\e[31m%})Status %?%{\e[0m\e[7m%}%1(j. : Job(s) %j.) ]%{\e[0m%}
%# '
source  ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
