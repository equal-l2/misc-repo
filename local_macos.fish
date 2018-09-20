set -x LANG en_US.UTF-8
set -x LC_ALL en_US.UTF-8
set -x RUSTFLAGS '-C linker=rust-lld -Z linker-flavor=ld64.lld'
set -x RUST_SRC_PATH ~/.rustup/toolchains/nightly-x86_64-apple-darwin/lib/rustlib/src/rust/src

set -x JAVA_HOME `/usr/libexec/java_home`
set -x PATH ~/clogsys ~/bin /usr/local/sbin /usr/local/opt/texinfo/bin ~/go/bin /opt/metasploit-framework/bin/ ~/.cargo/bin /usr/local/bin $PATH

# opam configuration
source ~/.opam/opam-init/init.fish
