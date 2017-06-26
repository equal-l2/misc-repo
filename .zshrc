# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle ':completion:*' completer _complete _correct _approximate
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' menu select interactive
zstyle ':completion:*' use-cache true
zstyle :compinstall filename '~/.zshrc'
setopt menu_complete
setopt magic_equal_subst

autoload -Uz compinit
fpath+=~/.zfunc
compinit
# End of lines added by compinstall

autoload -U zmv
export EDITOR=nvim
alias lorem='echo "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."'
if [ $TERM = 'linux' ]; then
  export PROMPT="[%~] > "
else
  POWERLEVEL9K_MODE='nerdfont-complete'
  POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(dir dir_writable background_jobs)
  POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(vcs status)
  source  ~/.zsh/powerlevel9k/powerlevel9k.zsh-theme
fi
source  ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/.env.zsh
