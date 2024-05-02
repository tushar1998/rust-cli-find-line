## Rust CLI app to find keywords of a file in directory

### Platform Support
Currently support only for 
- aarch64-apple-darwin

Future support for 
- aarch64-unknown-linux-gnu
- x86_64-apple-darwin
- x86_64-unknown-linux-gnu

### Installation
```bash
curl -s https://raw.githubusercontent.com/tushar1998/rust-cli-find-line/v0.0.3/install.sh | bash
```

### Usage

```bash
$ findline --keywords react --path ./my-app --filename package.json --exclude-dir node_modules
```

