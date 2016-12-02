function usage_n_exit () {
  echo "Usage: $(basename "$0") user/repo"
  exit 1
}

if [ $# -ne 1 ]; then
  usage_n_exit
elif [ $(expr "$1" : "^[^\/ ]\{1,\}\/[^\/ ]\{1,\}$") -eq 0 ]; then
  usage_n_exit
fi

EXECSTR="git clone https://github.com/$*"
echo $EXECSTR
eval $EXECSTR
