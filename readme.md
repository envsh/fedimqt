

```
// .svg not work
// 
// https://mui.com/material-ui/material-icons/
// https://github.com/OlivierLDff/MaterialDesignSvgo
```

### 编译android初始化

[todotodototodo](https://doc.qt.io/Qt-6/android-building-projects-from-commandline.html#:~:text=The%20command%20below%20shows%20the%20easiest%20way%20to,~%2FQt%2F%3Cqt_version%3E%2Fandroid_%3Cabi%3E%2Fbin%2Fqt-cmake%20%20-DQT_ANDROID_BUILD_ALL_ABIS%3DTRUE%20%20-DANDROID_SDK_ROOT%3D~%2FAndroid%2FSdk%20%20-DANDROID_NDK_ROOT%3D~%2FAndroid%2FSdk%2Fndk%2F26.1.10909125%20%5C)


cd android_arm64_v8a/sbin/
ln -sv /usr/local/Caskroom/android-ndk/26d/AndroidNDK11579264.app/Contents/NDK/toolchains/llvm/prebuilt/darwin-x86_64/sysroot/usr//include/vulkan
ln -sv /usr/local/Caskroom/android-ndk/26d/AndroidNDK11579264.app/Contents/NDK/toolchains/llvm/prebuilt/darwin-x86_64/sysroot/usr/include/GLES2
```
mkdir build && cd build
/opt/qt/6.7.0/android_arm64_v8a/bin/qt-cmake \
    -DANDROID_SDK_ROOT=/opt/android-sdk \
    -DANDROID_NDK_ROOT=/usr/local/Caskroom/android-ndk/26d/AndroidNDK11579264.app/Contents/NDK -DQT_HOST_PATH=$HOME/.nix-profile/ -DQT_HOST_PATH_CMAKE_DIR=$HOME/.nix-profile/lib/cmake -DQT_DEBUG_FIND_PACKAGE=ON   -DQT_ANDROID_ABIS="arm64-v8a" \
    -S .. -B .   -G "Unix Makefiles"

```

如果不是使用aqtinstall安装的desktop包,需要额外设置这两个值,

```
-DQT_HOST_PATH
-DQT_HOST_PATH_CMAKE_DIR
```

### aqtinstall 安装预编译sdk
安装目录树, 
```
/opt/qt/{6.7.0,6.6.3}/{android_arm64_v8a, macos}
```

```
~/pyenv/bin/aqt version
v3.1.16
~/pyenv/bin/aqt install-qt mac android  6.7.0 android_arm64_v8a --autodesktop --outputdir /opt/qt
~/pyenv/bin/aqt install-qt mac android  6.6.3 android_arm64_v8a --autodesktop --outputdir /opt/qt
```
