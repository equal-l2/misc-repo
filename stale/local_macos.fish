set -x fish_emoji_width 2
set -x LANG en_US.UTF-8
set -x LC_ALL en_US.UTF-8
set -x RUST_SRC_PATH ~/.rustup/toolchains/nightly-x86_64-apple-darwin/lib/rustlib/src/rust/src

set -x JAVA_HOME (/usr/libexec/java_home)
set -x PATH ~/clogsys ~/bin /usr/local/sbin /usr/local/opt/texinfo/bin ~/go/bin /opt/metasploit-framework/bin/ /usr/local/bin $PATH
set -x HOMEBREW_DEVELOPER

function daily-update
  brew upgrade --fetch-HEAD

  brew cask upgrade --greedy

  rustup update
  cargo install-update -a

  pip3 list --outdated --format=columns
  npm up -g
end

function cc-san
  cc \
  -g \
  -fsanitize=address,integer,nullability,undefined \
  -fno-omit-frame-pointer \
  -fno-optimize-sibling-calls \
  -fsanitize-address-use-after-scope \
  $argv
end

function c++-san
  c++ \
  -g \
  -fsanitize=address,integer,nullability,undefined \
  -fno-omit-frame-pointer \
  -fno-optimize-sibling-calls \
  -fsanitize-address-use-after-scope \
  $argv
end

