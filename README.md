# advent_of_code_2020

Developed on Ubuntu 20.04 using WSL2. Assembly files are 32-bit and require 32-bit compatibility for gcc/libraries, and NASM to compile:

```bash
sudo apt-get install nasm
sudo apt-get install gcc-multilib
sudo apt-get install g++-multilib
```

Note: The compiled binaries are 32-bit and can be run on WSL2, but not WSL1:
https://stackoverflow.com/questions/42120938/exec-format-error-32-bit-executable-windows-subsystem-for-linux
