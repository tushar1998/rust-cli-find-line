Architecture

Apple
 - Mac OS on arm64 -> aarch64-apple-darwin
   - `cross build --release --target=aarch64-apple-darwin`

 - Mac OS on amd64 -> x86_64-apple-darwin
   - `cross build --release --target=x86_64-apple-darwin`

Linux - GNU
 - Ubuntu on arm64 -> aarch64-unknown-linux-gnu
   - `docker pull --platform linux/arm64/v8 ubuntu:jammy`
   - `cross build --release --target=aarch64-unknown-linux-gnu`

 - Ubuntu on amd64 -> x86_64-unknown-linux-gnu
   - `docker pull --platform linux/amd64 ubuntu:jammy`
   - `cross build --release --target=x86_64-unknown-linux-gnu`

Linux - MUSL
 - Alpine on arm64 -> aarch-unknown-linux-musl
   - `docker pull --platform linux/arm64/v8 alpine:latest`
   - `cross build --release --target=aarch-unknown-linux-musl`

 - Alpine on amd64 -> x86_64-unknown-linux-musl
   - `docker pull --platform linux/amd64 alpine:latest`
   - `cross build --release --target=x86_64-unknown-linux-musl`
