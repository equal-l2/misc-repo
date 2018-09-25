set -x EDITOR nvim
set -x MANPAGER "nvim -c 'set ft=man' -"

set -x RUST_BACKTRACE 1
set -x PATH ~/.cargo/bin $PATH
alias ls 'exa -aFs Extension'

set fish_greeting

function __remove_escape_sequences -a str
  string replace -ra '\\\\e\[.*?m' '' $str
end

function __longest_path -a len
  set -g fish_prompt_pwd_dir_length 0
  set -l getlen 'string length (prompt_pwd)'
  if test (eval $getlen) -gt $len
    # echo 'the raw path is too long'
    set -g fish_prompt_pwd_dir_length 1
    if test (eval $getlen) -le $len
      # echo 'determine the longest $fish_prompt_pwd_dir_length'
      while test (eval $getlen) -le $len
        set -g fish_prompt_pwd_dir_length (math $fish_prompt_pwd_dir_length + 1)
      end
      set -g fish_prompt_pwd_dir_length (math $fish_prompt_pwd_dir_length - 1)
    end
  end
  prompt_pwd
end

function fish_prompt --description "My own prompt!"
  set -l last_status $status

  # return code
  set -l statstr
  if test $last_status -eq 0
      set statstr '\e[32m'
  else
      set statstr '\e[31m'
  end
  set statstr (string join '' $statstr "Status $last_status\e[39m")

  # jobs (if exist)
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

  # generate prompt
  set -l p1 '\e[7m[ '
  set -l p2 " : $statstr $job]\e[m"

  # count prompt length
  set -l p1len (string length (__remove_escape_sequences $p1))
  set -l p2len (string length (__remove_escape_sequences $p2))
  set -l remainder (math "$COLUMNS-($p1len+$p2len)")

  # print prompts
  echo
  echo -e $p1(__longest_path $remainder)$p2
  switch "$USER"
    case root toor
      echo '# '
    case '*'
      echo '% '
  end
end
