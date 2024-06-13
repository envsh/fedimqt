

rm -rf build/*
# export CMAKE_MAKE_PROGRAM=ninja
export QT_HOST_PATH=/opt/qt/6.6.3/macos
# --debug-find-pkg=GLESv2
    # -DQT_ANDROID_ABIS="aarch64,arm64-v8a" \

/opt/qt/6.6.3/android_arm64_v8a/bin/qt-cmake  --debug-find-pkg=GLESv2 -DQT_DEBUG_FIND_PACKAGE=ON  -DQT_ANDROID_ABIS="arm64-v8a" \
    -DANDROID_SDK_ROOT=/opt/android-sdk \
    -DANDROID_NDK_ROOT=/usr/local/Caskroom/android-ndk/26d/AndroidNDK11579264.app/Contents/NDK \
    -S . -B build/ \
    -G "Unix Makefiles"
# -GNinja


# /usr/local/Caskroom/android-ndk/26d/AndroidNDK11579264.app/Contents/NDK//toolchains/llvm/prebuilt/darwin-x86_64/sysroot/usr/lib/aarch64-linux-android/32/libGLESv3.so
