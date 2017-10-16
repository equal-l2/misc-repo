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
POWERLEVEL9K_MODE='nerdfont-complete'
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(dir dir_writable background_jobs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(vcs status)

source  ~/.zsh/powerlevel9k/powerlevel9k.zsh-theme
source  ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
