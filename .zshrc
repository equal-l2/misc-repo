# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '~/.zshrc'

autoload -Uz compinit
fpath+=~/.zfunc
compinit
# End of lines added by compinstall

export EDITOR=nvim
export PATH=$PATH:/usr/local/sbin:~/bin
export JAVA_HOME=`/usr/libexec/java_home`
alias ls='ls -AGF'
alias lorem='echo "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."'
POWERLEVEL9K_MODE='nerdfont-complete'
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(dir dir_writable background_jobs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(vcs status)
source  ~/.zsh/powerlevel9k/powerlevel9k.zsh-theme
source  ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
export RUST_BACKTRACE=full
