set -x EDITOR nvim
set -x MANPAGER "nvim -c 'set ft=man' -"

set -x RUST_BACKTRACE 1
set -x PATH ~/.cargo/bin $PATH
alias ls 'exa -aFs Extension'

set fish_greeting
set fish_prompt_pwd_dir_length 0

function fish_prompt --description "My own prompt!"
  set -l last_status $status
  set -l suffix
  switch "$USER"
    case root toor
      set suffix '#'
    case '*'
      set suffix '%'
  end

  set -l statstr '\e[3'
  if test $last_status -eq 0
      set statstr (string join '' $statstr 2)
  else
      set statstr (string join '' $statstr 1)
  end
  set statstr (string join '' $statstr "mStatus $last_status\e[39m")

  set -l jobcnt (count (jobs))
  set -l job ' : Job'
  if test $jobcnt -ne 0
    if test $jobcnt -gt 1
      set job (string join '' $job 's')
    end
    set job (string join '' $job " $jobcnt ")
  else
    set job ''
  end


  echo -e '\n\e[7m[ '(prompt_pwd)" : $statstr $job]\e[m\n$suffix "
end

if status is-interactive
and not set -q TMUX
    tmux
end
