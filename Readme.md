## Rust CLI app to find keywords of a file in directory

### Platform Support

Currently support only for

- aarch64-apple-darwin
- aarch64-unknown-linux-gnu
- aarch64-unknown-linux-musl
- x86_64-apple-darwin
- x86_64-unknown-linux-gnu
- x86_64-unknown-linux-musl

Future support for

- aarch64-pc-windows-msvc
- x86_64-pc-windows-gnu
- x86_64-pc-windows-msvc
- aarch64-pc-windows-gnullvm

### Installation

```bash
curl -s https://raw.githubusercontent.com/tushar1998/rust-cli-find-line/v0.1.0-dev.5/install.sh | bash
```

### Usage

```bash
$ findline --keywords react --path ./my-app --filename package.json --exclude-dir node_modules
```

Architecture System Matrix
| Architecture | System |
| -------- | ------- |
| aarch64-apple-darwin | Apple Silicon Macbooks |
| aarch64-unknown-linux-gnu | Ubuntu |
| aarch64-unknown-linux-musl | Alpine |
| x86_64-apple-darwin | Intel/AMD Chip Macbooks |
| x86_64-unknown-linux-musl | 64-bit Alpine |
| x86_64-unknown-linux-gnu | 64-bit Ubuntu |
| aarch64-pc-windows-gnullvm | Windows on ARM GNU |
| aarch64-pc-windows-msvc | Windows on ARM |
| x86_64-pc-windows-msvc | 64-bit Windows PC |
| x86_64-pc-windows-gnu | 64-bit WSL on Windows PC GNU |


