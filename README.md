# xc-bela-cmake
This repository (should) contain all you need to cross compile on Ubuntu for the bela plaftorm with the following toolchain
 - Linaro 7 for C++17 support
 - cmake >= 3.6
 - qemu-arm-static for local emulation & testing
 - VSCode integration
 - clangd integration

*This is a first really quick draft to start sharing it. If you notice anything please don't hesitate to open an issue, I'd like to help as much as possible.*

# Setup
## Prerequisites
On Ubuntu you'll probably requires this packages :
```bash
apt-get install build-essentials cmake git qemu-user-static clangd gdb-multiarch
```

Then clone the repo :
```bash
git clone --recurse-submodules git@github.com:maxmarsc/xc-bela-cmake.git
```

## Linaro
```bash
# Linaro
mkdir /usr/local/linaro
sudo chmod 777 /usr/local/linaro/
cd /usr/local/linaro
wget https://releases.linaro.org/components/toolchain/binaries/7.5-2019.12/arm-linux-gnueabihf/gcc-linaro-7.5.0-2019.12-x86_64_arm-linux-gnueabihf.tar.xz
tar xf gcc-linaro-7.5.0-2019.12-x86_64_arm-linux-gnueabihf.tar.xz
mv gcc-linaro-7.5.0-2019.12-x86_64_arm-linux-gnueabihf arm-bela-linux-gnueabihf
rm -r gcc-linaro-7.5.0-2019.12.02-x86_64_arm-linux-gnueabihf.tar.xz
```

## Bela librairies and headers
**Warning :** this could delete the projects located on your board, in doubt make a backup 

```bash
# Build the libraries -- needs the Bela board to be connected
scp BelaExtras/CustomMakefile* root@bela.local:~/Bela
ssh root@bela.local "cd Bela && rm lib/*"
ssh root@bela.local "cd Bela && make -f Makefile.libraries cleanall && make -f Makefile.libraries all"
ssh root@bela.local "cd Bela && make lib && make libbelafull"

# Bela Sysroot -- needs the Bela board to be connected
./BelaExtras/SyncBelaSysroot.sh

# Additional step to install gdbserver on the board for remote debugging
ssh root@bela.local "apt-get install -y gdbserver"

```

# Build & testing
To build with cmake on the command line run :
```bash
cmake -B build -DCMAKE_TOOLCHAIN_FILE:FILEPATH=Toolchain.cmake .
cmake --build build -j$(nproc) --target bela_executable
```

## Testing
CMake is preconfigured to call `qemu-arm-static` to run any Bela executable on your machine. If you want to do it manually you can do it this way :
```bash
qemu-arm-static -L /usr/local/linaro/arm-bela-linux-gnueabihf/arm-linux-gnueabihf/libc <your_executable>
```

## VSCode integration
I try to integrate as much as I could into VSCode workflow. I suggest the following extensions :
 - [Basic C/C++ support](https://marketplace.visualstudio.com/items?itemName=ms-vscode.cpptools)
 - [Clangd for better linting](https://marketplace.visualstudio.com/items?itemName=llvm-vs-code-extensions.vscode-clangd)
 - [Native debugger for cross and remote debugging](https://marketplace.visualstudio.com/items?itemName=webfreak.debug)
 - [CMake support](https://marketplace.visualstudio.com/items?itemName=ms-vscode.cmake-tools)

Once the toolchain is selected for cmake you can use the CMake integration quite easily

### Debugging targets
I provided two debugging targets (using the `native-debugger` extension):
 - `[Tests] Attach to local gdbserver` : localy run tests using qemu, default to build/bin/tests
- `[Belacid] Attach to gdbserver` : remotly start the exectuable with gdbserver on the Bela board and connect to it with gdb-multiarch


# Kudos
Thanks to these repos for hints & tips,
 - [OSXBelaCrossCompiler : for OSX](https://github.com/AndrewCapon/OSXBelaCrossCompiler)
 - [xcBela : generic xc bela env with cmake and gcc](https://github.com/thetechnobear/xcBela)
 - [xc-bela-container : cmake and vscode integration using Docker dev envs](https://github.com/ebai101/xc-bela-container)