################################################################################
1. How to Build
        - get Toolchain
                get the proper toolchain packages from AOSP or CodeSourcery or ETC.

        - edit Makefile
                edit "CROSS_COMPILE" to right toolchain path(You downloaded).
                        EX)  CROSS_COMPILE=<android platform directory you download>/android/prebuilts/gcc/linux-x86/aarch64/aarch64-linux-android-4.9/bin/aarch64-linux-android-
                        EX)  CROSS_COMPILE=/usr/local/toolchain/gcc/linux-x86/aarch64/aarch64-linux-android-4.9/bin/aarch64-linux-android- // check the location of toolchain
                edit "CLANG" to right path(You downloaded).
                        EX)  CC=<android platform directory you download>/android/prebuilts/clang/host/linux-x86/clang-r383902/bin/clang
                        EX)  CC=/usr/local/toolchain/clang/host/linux-x86/clang-r383902/bin/clang // check the location of toolchain
                edit "CLANG_TRIPLE" to right path(You downloaded).
                        EX)  CLANG_TRIPLE=<android platform directory you download>/android/prebuilts/clang/host/linux-x86/clang-r383902/bin/aarch64-linux-gnu-
                        EX)  CLANG_TRIPLE=/usr/local/toolchain/clang/host/linux-x86/clang-r383902/bin/aarch64-linux-gnu- // check the location of toolchain     
        - to Build
                $ export PLATFORM_VERSION=12
                $ export ANDROID_MAJOR_VERSION=s
                $ export ARCH=arm64
                $ make exynos850-a04sxx_defconfig
                $ make

2. Output files
        - Kernel : arch/arm64/boot/Image
        - module : drivers/*/*.ko

3. How to Clean
        $ make clean
################################################################################
