#Kernel-Compiling-Script

#!/bin/bash
KERNEL_DIR=$(pwd)
ANYKERNEL3_DIR="${KERNEL_DIR}/AnyKernel3"
export PATH="${KERNEL_DIR}/clang/bin:${PATH}"
export KBUILD_COMPILER_STRING="(${KERNEL_DIR}/clang/bin/clang --version | head -n 1 | perl -pe 's/\((?:http|git).*?\)//gs' | sed -e 's/  */ /g' -e 's/[[:space:]]*$//' -e 's/^.*clang/clang/')"
export ARCH=arm64
export SUBARCH=arm64
export KBUILD_BUILD_USER=brucetech627
export KBUILD_BUILD_HOST=circleci
# Compile plox
function compile() {
    make sweet_user_defconfig O=out
    make -j$(nproc --all) O=out \
                      ARCH=arm64 \
                      CC=clang \
                      CROSS_COMPILE=aarch64-linux-gnu- \
                      CROSS_COMPILE_ARM32=arm-linux-gnueabi- \
                      NM=llvm-nm \
                      OBJCOPY=llvm-objcopy \
                      OBJDUMP=llvm-objdump \
                      STRIP=llvm-strip

echo "**** Verify Image.gz-dtb & dtbo.img ****"
ls $PWD/out/arch/arm64/boot/Image.gz-dtb
}
# Zipping
function zipping() {
    cp $PWD/out/arch/arm64/boot/Image.gz-dtb $ANYKERNEL3_DIR/
    cd $ANYKERNEL3_DIR || exit 1
    zip -r9 Sweet-StormBreaker.zip *
    curl https://bashupload.com/Sweet-StormBreaker.zip --data-binary @Sweet-StormBreaker.zip
}
compile
zipping
