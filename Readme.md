## Rust CLI app to find keywords of a file in directory

### Platform Support

Currently support only for

- aarch64-apple-darwin

Future support for

- aarch64-unknown-linux-gnu
- aarch-unknown-linux-musl
- aarch64-pc-windows-msvc *
- aarch64-pc-windows-gnu *

- x86_64-apple-darwin
- x86_64-unknown-linux-gnu
- x86_64-unknown-linux-musl
- x86_64-pc-windows-msvc *
- x86_64-pc-windows-gnu *

* - Might not consider the support

### Installation

```bash
curl -s https://raw.githubusercontent.com/tushar1998/rust-cli-find-line/v0.0.5/install.sh | bash
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
| aarch-unknown-linux-musl | Alpine |
| aarch64-pc-windows-msvc | Windows PC |
| aarch64-pc-windows-gnu | WSL on Windows PC |
| x86_64-apple-darwin | Intel/AMD Chip Macbooks |
| x86_64-unknown-linux-musl | 64-bit Alpine |
| x86_64-unknown-linux-gnu | 64-bit Ubuntu |
| x86_64-pc-windows-msvc | 64-bit Windows PC |
| x86_64-pc-windows-gnu | 64-bit WSL on Windows PC |


