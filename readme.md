

```
// .svg not work
// 
// https://mui.com/material-ui/material-icons/
// https://github.com/OlivierLDff/MaterialDesignSvgo
```

### 编译android初始化

todotodototodo

```
mkdir build && cd build
ANDROID_NDK_ROOT=/usr/local/Caskroom/android-ndk/26d/AndroidNDK11579264.app/Contents/NDK  ANDROID_SDK_ROOT=/opt/android-sdk /opt/qt/6.6.3/android_arm64_v8a/bin/qt-cmake -G "Unix Makefiles" ../

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
