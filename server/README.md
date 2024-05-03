## Setup dev environment
#### Install rustup target
```rustup target add arm-unknown-linux-gnueabihf```
#### Install linker and gcc
```sudo apt install gcc-arm-linux-gnueabihf```
```sudo apt install build-essential```
#### Build project
```cargo build --release --target=arm-unknown-linux-gnueabihf```