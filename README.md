# Set up

Install Meson
- sudo apt install python3 python3-pip
- pip3 install meson
- sudo apt install ninja-build

GCC
- sudo apt install build-essential
- sudo apt install gcc binutils

Clang
- sudo apt-get install clang lld llvm clang-tools

CMocka
- sudo apt install libcmocka0 libcmocka-dev

Make
- sudo apt install make

pkg-config
- sudo apt install pkg-config

Supporting Tooling

    Doxygen
    CppCheck
    clang-format
    clang-tidy
    gcovr
    lcov
    genhtml
    scan-build (Clang)
    lizard
- sudo apt install doxygen cppcheck gcovr lcov clang-format clang-tidy clang-tools

## External Dependencies

- [Cmocka](https://cmocka.org/)
- [juliamath/openlibm](https://github.com/JuliaMath/openlibm)
- [mpaland/printf](https://github.com/mpaland/printf)

## Rebuild entire directory
This will clean the build dir:

$ ninja -C builddir clean

This will force a reconfigure:

$ ninja -C builddir reconfigure

But you may also just as well nuke the entire builddir and just do a
fresh meson build from scratch:

$ [delete builddir]
$ meson builddir
$ ninja -C builddir 