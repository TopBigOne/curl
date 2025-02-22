#!/bin/bash

source ./build-android-env.sh

DIR=$PWD
echo "build path is in $DIR"
echo " "

#cd $DIR
echo "筱雅 curr path is ${PWD}"


function build() {
    export TARGET_HOST=$1
    export ANDROID_ARCH=$2
    export AR=$TOOLCHAIN/bin/llvm-ar
    export CC=$TOOLCHAIN/bin/$TARGET_HOST$MIN_SDK_VERSION-clang
    export AS=$CC
    export CXX=$TOOLCHAIN/bin/$TARGET_HOST$MIN_SDK_VERSION-clang++
    export LD=$TOOLCHAIN/bin/ld
    export RANLIB=$TOOLCHAIN/bin/llvm-ranlib
    export STRIP=$TOOLCHAIN/bin/llvm-strip
    echo "| ----------------------------------------------------↓"
    echo "| TARGET_HOST  is : $TARGET_HOST"
    echo "| ANDROID_ARCH is : $ANDROID_ARCH"
    echo "| ----------------------------------------------------↑"

    echo "curr path is ${PWD}"


    ./configure --host=$TARGET_HOST \
                --target=$TARGET_HOST \
                --prefix=$INSTALL_DIR/$ANDROID_ARCH \
                --with-zlib=$BUILD_DIR/zlib/$ANDROID_ARCH \
                --with-openssl=$BUILD_DIR/openssl/$ANDROID_ARCH \
                --with-pic --disable-shared

    make -j8
    make install
    make clean
}


build aarch64-linux-android arm64-v8a
#build armv7a-linux-androideabi armeabi-v7a
#build i686-linux-android x86
#build x86_64-linux-android x86_64

# cd ..

