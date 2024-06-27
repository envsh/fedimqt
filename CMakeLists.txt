cmake_minimum_required(VERSION 3.16)

project(helloworld VERSION 1.0.1 LANGUAGES CXX C)


set(CMAKE_C_STANDARD 99)
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_FLAGS "-g -ggdb -O0")
# set(CMAKE_VERBOSE_MAKEFILE true)
set(CMAKE_CXX_EXTENSIONS off)

find_package(Qt6 REQUIRED COMPONENTS Core)
find_package(Qt6 REQUIRED COMPONENTS Widgets)
# declaretive
find_package(Qt6 REQUIRED COMPONENTS Qml)
find_package(Qt6 REQUIRED COMPONENTS QmlIntegration)
find_package(Qt6 REQUIRED COMPONENTS Quick)
find_package(Qt6 REQUIRED COMPONENTS QuickControls2)
find_package(Qt6 REQUIRED COMPONENTS QuickTemplates2)

qt_standard_project_setup()
# set(QT_DEBUG_FIND_PACKAGE ON)
set(shextsfx ${CMAKE_SHARED_LIBRARY_SUFFIX})
set(projdir ${PROJECT_SOURCE_DIR})
# set(projsrcdir ${CMAKE_HOME_DIRECTORY})
message("Building target: ${CMAKE_SYSTEM_NAME}")
set(tgos ${CMAKE_SYSTEM_NAME})

qt_wrap_ui(UISRCS vlistview.ui)

set(MAINSRC
    ${UISRCS}
    # ./uis/vlistview.ui

    srcc/mainglob.cpp
    srcc/qtuninline.cpp
    srcc/modelbase.cpp
    QmlCppBridge.cpp
    myitemdg.cpp
    myview.cpp
    vlistview.cpp
    maincxx.cpp
    mainc.c
)
# not work
# set(ANDROID_JAVA_SOURCE_DIR "${projdir}/adjava")
# set(ANDROID_PACKAGE_SOURCE_DIR "${projdir}/adjava")

if(${ANDROID})
qt_add_executable(helloworld ${MAINSRC})
# set_property(TARGET helloworld PROPERTY QT_ANDROID_PACKAGE_SOURCE_DIR
#           "${projdir}/adjava")
else() ### ANDROI
qt_add_library(helloworld SHARED ${MAINSRC})
endif()
if(ANDROID)
    set(ANDROID_PACKAGE_SOURCE_DIR "${CMAKE_CURRENT_SOURCE_DIR}/adjava")
    set_property(TARGET helloworld PROPERTY QT_ANDROID_PACKAGE_SOURCE_DIR ${ANDROID_PACKAGE_SOURCE_DIR})
    # add_custom_target(cmake_android_package
    #     SOURCES
    #     ${ANDROID_PACKAGE_SOURCE_DIR}/AndroidManifest.xml
    #     ${ANDROID_PACKAGE_SOURCE_DIR}/build.gradle
    #     ${ANDROID_PACKAGE_SOURCE_DIR}/grable.properties
    #     ${ANDROID_PACKAGE_SOURCE_DIR}/res/values/libs.xml
    # )

    # include(D:/Dev/Dev/android_openssl/CMakeLists.txt)
endif()

# must before qt_add_qml_module
set_source_files_properties(srcui/Sss.qml
    qmlpp/MySingleton.qml qmlpp/MySingletonui.qml
    PROPERTIES QT_QML_SINGLETON_TYPE TRUE)
# message("and... ${ANDROID}")
# must relative path
file(GLOB qmlfiles CONFIGURE_DEPENDS RELATIVE ${projdir} srcui/*.qml
    qmlpp/*.qml qmlpp/*.js)
file(GLOB iconfiles CONFIGURE_DEPENDS RELATIVE ${projdir} icons/*.png icons/*.gif)
# message("icons ${qmlfiles}")
if(${ANDROID})
qt_add_qml_module(helloworld
    URI mainqml
    VERSION 1.0
    # RESOURCE_PREFIX /my.company.com/imports
    RESOURCE_PREFIX /
    DEPENDENCIES QtQuick QtQuickControls2
)
qt_target_qml_sources(helloworld
    QML_FILES main.qml
    # srcui/MyText.qml srcui/MyComboBox.qml srcui/MyButton.qml
    # srcui/MyImage.qml srcui/HelloModel.qml srcui/Logui.qml
    # srcui/Loginui.qml srcui/Aboutui.qml srcui/ShareState.qml
    # srcui/RoomListView.qml srcui/MsgListView.qml srcui/Settingui.qml
    # srcui/MsgText.qml srcui/MySingleton.qml srcui/MySingletonui.qml

    ${qmlfiles}
    srcui/qmldir
    qmlpp/qmldir
    # com/melije/pulltorefresh/RefreshIndicator.qml
    # com/melije/pulltorefresh/PullToRefreshHandler.qml
    # com/melije/pulltorefresh/qmldir
    
    # RESOURCES icons/logo.png
    RESOURCES ${iconfiles}
)
endif()

### android 上是 cppexe link golib
### pc 上是 goexe link cpplib
if(${ANDROID})
set(GOLIB "hellogo")
endif()
target_link_libraries(helloworld PRIVATE
    Qt6::Widgets Qt6::Qml Qt6::QmlIntegration Qt6::Quick
    Qt6::QuickControls2 Qt6::QuickTemplates2
    # 以下添加 private header
    Qt6::QuickPrivate Qt6::QuickControls2Private Qt6::QuickTemplates2Private
    ${GOLIB}
)
target_link_directories(helloworld PUBLIC "./")

set_target_properties(helloworld PROPERTIES
    WIN32_EXECUTABLE ON
    MACOSX_BUNDLE ON
    # QT_QML_ROOT_PATH ""
    # QT_QML_IMPORT_PATH "~/.nix-profile/lib/qt-6/qml/"
)


# add_custom_command(OUTPUT out1 COMMAND "tsc -v")
# message("${out1}")

add_custom_command(OUTPUT ${projdir}/qmlpp/Qmlpp.js
    COMMENT "tscc {tspp,Qmlpp}.ts 111"
    # COMMAND "tsc" "-v"
    COMMAND tsc --pretty --sourceMap --declaration --module commonjs --lib es6,es2020,dom --esModuleInterop --types "Qt" "${projdir}/qmlpp/Qmlpp.ts"
    # fix https://stackoverflow.com/questions/43042889/typescript-referenceerror-exports-is-not-defined
    # COMMAND "sed" "-i" ".bak" "'s/^\"use strict\";/.pragma library\\n\\nvar exports = {};\\n\\n\"use strict\";/g'" "${projdir}/qmlpp/Tspp.js"
    COMMAND "sed" "-i" ".bak" "'s/^\"use strict\";/.pragma library\\n\\nvar exports = {};\\n\\n\"use strict\";/g'" "${projdir}/qmlpp/Qmlpp.js"
    DEPENDS ${projdir}/qmlpp/Qmlpp.ts)
add_custom_target(tscc COMMENT "tscc {tspp,Qmlpp}.ts 222"
    DEPENDS ${projdir}/qmlpp/Qmlpp.js
)
add_dependencies(helloworld tscc)

if(${ANDROID})
# message("ANDROID_NDK_ROOT=${ANDROID_NDK_ROOT}")
set(NDKSYSROOT "${ANDROID_NDK_ROOT}/toolchains/llvm/prebuilt/darwin-x86_64/sysroot")
set(CGO_CFLAGSx "-g -O0 -arch arm64 ")
set(CGO_CCx "${NDKSYSROOT}/../bin/aarch64-linux-android21-clang")
# message("CGO_CFLAGS=${CGO_CFLAGSx}, CGO_LDFLAGS=${CGO_LDFLAGSx}")
add_custom_command(OUTPUT ../jniLibs/libhellogo.h
    WORKING_DIRECTORY "${CMAKE_HOME_DIRECTORY}/srcgo"
    COMMAND pwd && go version
    COMMAND GOOS=android GOARCH=arm64 CC="${CGO_CCx}" CGO_CFLAGS="\"${CGO_CFLAGSx}\"" CGO_LDFLAGS="\"-arch arm64\"" CGO_ENABLED=1 go build -tags usejni -buildmode=c-shared -o ../jniLIbs/libhellogo${shextsfx} ./
    COMMAND ls -lh ../jniLibs/libhellogo${shextsfx} && file ../jniLibs/libhellogo${shextsfx}
    # 好像这个没有什么用
    COMMAND cp ../jniLibs/libhellogo${shextsfx} ../build/
    # 好像link时用的这个
    COMMAND cp ../jniLibs/libhellogo${shextsfx} ../
    # 好像打包apk用的这个
    COMMAND cp ../jniLibs/libhellogo${shextsfx} ../build/android-build/libs/arm64-v8a/
    # SOURCES ./srcgo/*.go ./srcgo/go.*
    # COMMAND_EXPAND_LISTS
    DEPENDS ${projdir}/srcgo/*.go ${projdir}/srcgo/go.mod
)
add_custom_target(gocc COMMENT "gocc222 for android" DEPENDS ../jniLibs/libhellogo.h)
add_dependencies(helloworld gocc)
else() #############
# 二进制减小1/3,内存减少3,4M,基本没变化.
# set(CGO_LDFLAGSx "-L../ -lhelloworld -w -s")
set(CGO_LDFLAGSx "-L../ -lhelloworld")
# message("CGO_CFLAGS=${CGO_CFLAGSx}, CGO_LDFLAGS=${CGO_LDFLAGSx}")
add_custom_command(OUTPUT ../hellogo COMMENT "gocc111"
    WORKING_DIRECTORY "${CMAKE_HOME_DIRECTORY}/srcgo"
    COMMAND pwd && go version
    # COMMAND go build -buildmode=c-shared -o ../libhellogo${shextsfx} ./
    # COMMAND ls -lh ../libhellogo${shextsfx} && file ../libhellogo${shextsfx}
    COMMAND XXX=5 CGO_LDFLAGS=${CGO_LDFLAGSx} CGO_ENABLED=1 go build -v -o ../hellogo ./
    COMMAND ls -lh ../hellogo && file ../hellogo
    DEPENDS ${projdir}/srcgo/*.go ${projdir}/srcgo/go.mod
    # COMMAND_EXPAND_LISTS
)
add_custom_target(gocc COMMENT "gocc222" DEPENDS ../hellogo )
# add_dependencies(gocc helloworld)
endif()


add_custom_target(showapk
    COMMAND pwd
    COMMAND ls -lh ${projdir}/build/android-build/build/outputs/apk/debug/android-build-debug.apk
    COMMAND ls -lh ${projdir}/build/android-build/helloworld.apk
)
# add_dependencies(showapk helloworld)

add_custom_target(chkldd 
    COMMAND echo "checking android libhelloworld.so ...."
    COMMAND objdump -x ${projdir}/build/libhelloworld_arm64-v8a.so|grep NEEDED
    COMMAND echo "checking android libhellogo.so ...."
    COMMAND objdump -x ${projdir}/build/libhellogo.so|grep NEEDED

    # COMMAND echo "checking desktop libhellogo.so ...."
    COMMAND otool -L ${projdir}/hellogo

    COMMAND otool -L ${projdir}/libhelloworld.dylib
)

#####
# qt_generate_deploy_qml_app_script(
#     TARGET helloworld
#     OUTPUT_SCRIPT deploy_script
#     MACOS_BUNDLE_POST_BUILD
#     NO_UNSUPPORTED_PLATFORM_ERROR
#     DEPLOY_USER_QML_MODULES_ON_UNSUPPORTED_PLATFORM
# )

### clean some
add_custom_target(clngo rm -fv ${projdir}/libhellogo.h ${projdir}/jniLibs/libhellogo.h)
add_custom_target(clnts rm -fv qmlpp/tspp.js qmlpp/tspp.js.map qmlpp/tspp.d.ts qmlpp/Qmlpp.js qmlpp/Qmlpp.js.map qmlpp/Qmlpp.d.ts
)

add_custom_target(clnapk WORKING_DIRECTORY "${projdir}/build"
    COMMAND rm -fv build/android-build/helloworld.apk build/android-build/build/outputs/apk/debug/android-build-debug.apk android-build/helloworld.apk android-build/build/outputs/apk/debug/android-build-debug.apk)
add_custom_target(decapk WORKING_DIRECTORY "${projdir}/build"
    COMMAND apktool d -f -o pkgapk android-build/helloworld.apk
)

add_custom_target(instapk WORKING_DIRECTORY "${projdir}/build"
    COMMAND /opt/android-sdk/adbtools/adb install  android-build/helloworld.apk )