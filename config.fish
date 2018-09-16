set -x LANG en_US.UTF-8
set -x LC_ALL en_US.UTF-8
set -x EDITOR nvim
set -x MANPAGER "nvim -c 'set ft=man' -"

set -x RUST_BACKTRACE 1
set -x RUSTFLAGS '-C linker=rust-lld -Z linker-flavor=ld64.lld'
set -x RUST_SRC_PATH ~/.rustup/toolchains/nightly-x86_64-apple-darwin/lib/rustlib/src/rust/src

set -x JAVA_HOME `/usr/libexec/java_home`
set -x PATH ~/clogsys ~/bin /usr/local/sbin /usr/local/opt/texinfo/bin ~/go/bin /opt/metasploit-framework/bin/ $PATH
alias ls 'exa -aFs Extension'

if status is-interactive
and not set -q TMUX
    exec tmux
end
