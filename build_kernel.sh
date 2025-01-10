#!/bin/bash

export RDIR="$(pwd)"
export ARCH=arm64
export KBUILD_BUILD_USER="@ravindu644"
export PLATFORM_VERSION=12
export ANDROID_MAJOR_VERSION=s

export BUILD_CROSS_COMPILE="${RDIR}/toolchain/gcc/linux-x86/aarch64/aarch64-linux-android-4.9/bin/aarch64-linux-android-"
export BUILD_CC="${RDIR}/toolchain/clang/host/linux-x86/clang-r353983c/bin/clang"

#output dir
if [ ! -d "${RDIR}/out" ]; then
    mkdir -p "${RDIR}/out"
fi

#build dir
if [ ! -d "${RDIR}/build" ]; then
    mkdir -p "${RDIR}/build"
else
    rm -rf "${RDIR}/build" && mkdir -p "${RDIR}/build"
fi

#build options
export ARGS="
-C $(pwd) \
O=$(pwd)/out \
-j$(nproc) \
ARCH=arm64 \
CROSS_COMPILE=${BUILD_CROSS_COMPILE} \
CC=${BUILD_CC} \
"

#build kernel image
build_kernel(){
    #make ${ARGS} clean && make ${ARGS} mrproper
    make ${ARGS} exynos850-a04sxx_defconfig a04s.config
    make ${ARGS} menuconfig
    make ${ARGS} || exit 1
}

#build boot.img
build_boot() {    
    rm -f ${RDIR}/AIK-Linux/split_img/boot.img-kernel ${RDIR}/AIK-Linux/boot.img
    cp "${RDIR}/out/arch/arm64/boot/Image" ${RDIR}/AIK-Linux/split_img/boot.img-kernel
    mkdir -p ${RDIR}/AIK-Linux/ramdisk/{debug_ramdisk,dev,metadata,mnt,proc,second_stage_resources,sys}
    cd ${RDIR}/AIK-Linux && ./repackimg.sh --nosudo && mv image-new.img ${RDIR}/build/boot.img
}

#build odin flashable tar
build_tar(){
    cd ${RDIR}/build
    tar -cvf "Kernel-SM-A047F.tar" boot.img && rm boot.img
    echo -e "\n[i] Build Finished..!\n" && cd ${RDIR}
}

build_kernel
build_boot
build_tar
