Embedded Devlopment Toolbox For Docker
======================================

Contains the following tools:

* Git
* SCons
* Make
* GCC
* GNU Arm Embedded Toolchain
* Microchip XC32 compiler
* Microchip Harmony
* CUnit
* Cppcheck
* SRecord


Example usage
-------------

One time build:

```sh
$ cd /my/folder/with/sources
$ docker run --rm -v $(pwd):/work embedded-toolbox scons
```

Stay in containers shell to continue building:

```sh
$ cd /my/folder/with/sources
$ docker run -it -v $(pwd):/work embedded-toolbox
```

