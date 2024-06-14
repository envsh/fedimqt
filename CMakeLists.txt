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
qt_standard_project_setup()
# set(QT_DEBUG_FIND_PACKAGE ON)
set(shextsfx ${CMAKE_SHARED_LIBRARY_SUFFIX})
set(projdir ${PROJECT_SOURCE_DIR})
# set(projsrcdir ${CMAKE_HOME_DIRECTORY})
message("Building target: ${CMAKE_SYSTEM_NAME}")
set(tgos ${CMAKE_SYSTEM_NAME})

qt_wrap_ui(UISRCS vlistview.ui)

qt_add_executable(helloworld
    ${UISRCS}
    # ./uis/vlistview.ui

    QmlCppBridge.cpp
    myitemdg.cpp
    myview.cpp
    vlistview.cpp
    maincxx.cpp
    mainc.c
)
# message("and... ${ANDROID}")
# todo this is absolute path, maybe not work, need relative path
file(GLOB qmlfiles CONFIGURE_DEPENDS srcui/*.qml)
file(GLOB iconfiles CONFIGURE_DEPENDS ./icons/*.png)
# message("icons ${iconfiles}")
if(${ANDROID})
qt_add_qml_module(helloworld
    URI mainqml
    VERSION 1.0
    # RESOURCE_PREFIX /my.company.com/imports
    RESOURCE_PREFIX /
)
qt_target_qml_sources(helloworld
    QML_FILES main.qml main.js
    srcui/MyText.qml srcui/MyComboBox.qml srcui/MyButton.qml
    srcui/MyImage.qml srcui/HelloModel.qml srcui/Logui.qml
    srcui/Loginui.qml srcui/Aboutui.qml srcui/ShareState.qml
    srcui/RoomListView.qml srcui/MsgListView.qml srcui/Settingui.qml
    # RESOURCES icons/logo.png
    RESOURCES ${iconfiles}
)
endif()

target_link_libraries(helloworld PRIVATE Qt6::Widgets Qt6::Qml Qt6::QmlIntegration Qt6::Quick Qt6::QuickControls2 hellogo)
target_link_directories(helloworld PUBLIC ".")

set_target_properties(helloworld PROPERTIES
    WIN32_EXECUTABLE ON
    MACOSX_BUNDLE ON
    # QT_QML_ROOT_PATH ""
    # QT_QML_IMPORT_PATH "~/.nix-profile/lib/qt-6/qml/"
)


# add_custom_command(OUTPUT out1 COMMAND "tsc -v")
# message("${out1}")
add_custom_command(OUTPUT ${projdir}/main.js COMMENT "tscc111"
    # COMMAND "tsc" "-v"
    COMMAND tsc --pretty --sourceMap --declaration --module commonjs --lib es2020,dom --esModuleInterop "${CMAKE_HOME_DIRECTORY}/main.ts"
    # fix https://stackoverflow.com/questions/43042889/typescript-referenceerror-exports-is-not-defined
    COMMAND "sed" "-i" ".bak" "'s/\"use strict\";/var exports = {};\\n\\n\"use strict\";/g'" "${CMAKE_HOME_DIRECTORY}/main.js"
    DEPENDS ${projdir}/main.ts)
add_custom_target(tscc COMMENT "tscc222"
    DEPENDS ${projdir}/main.js
)
add_dependencies(helloworld tscc)

if(${ANDROID})
# message(${ANDROID_NDK_ROOT})
set(NDKSYSROOT "${ANDROID_NDK_ROOT}/toolchains/llvm/prebuilt/darwin-x86_64/sysroot")
set(CGO_CFLAGSx "-g -O0 -arch arm64 ")
set(CGO_CCx "${NDKSYSROOT}/../bin/aarch64-linux-android21-clang")
message("CGO_CFLAGS=${CGO_CFLAGSx}")
add_custom_command(OUTPUT ../jniLibs/libhellogo.h
    WORKING_DIRECTORY "${CMAKE_HOME_DIRECTORY}/srcgo"
    COMMAND pwd && go version
    COMMAND GOOS=android GOARCH=arm64 CC="${CGO_CCx}" CGO_CFLAGS="\"${CGO_CFLAGSx}\"" CGO_LDFLAGS="\"-arch arm64\"" CGO_ENABLED=1 go build -buildmode=c-shared -o ../jniLIbs/libhellogo${shextsfx} ./
    COMMAND ls -lh ../jniLibs/libhellogo${shextsfx} && file ../jniLibs/libhellogo${shextsfx}
    COMMAND cp ../jniLibs/libhellogo${shextsfx} ../build/
    # SOURCES ./srcgo/*.go ./srcgo/go.*
    # COMMAND_EXPAND_LISTS
    DEPENDS ${projdir}/srcgo/*.go ${projdir}/srcgo/go.mod
)
add_custom_target(gocc COMMENT "gocc222 for android" DEPENDS ../jniLibs/libhellogo.h)
else() #############
add_custom_command(OUTPUT libhellogo.h COMMENT "gocc111"
    WORKING_DIRECTORY "${CMAKE_HOME_DIRECTORY}/srcgo"
    COMMAND pwd && go version
    COMMAND go build -buildmode=c-shared -o ../libhellogo${shextsfx} ./
    COMMAND ls -lh ../libhellogo${shextsfx} && file ../libhellogo${shextsfx}
    DEPENDS ${projdir}/srcgo/*.go
    # COMMAND_EXPAND_LISTS
)
add_custom_target(gocc COMMENT "gocc222" DEPENDS libhellogo.h )
endif()
add_dependencies(helloworld gocc)

add_custom_target(showapk
    COMMAND pwd
    COMMAND ls -lh ${projdir}/build/android-build/build/outputs/apk/debug/android-build-debug.apk
    COMMAND ls -lh ${projdir}/build/android-build/helloworld.apk
)
add_dependencies(showapk helloworld)

### clean some
add_custom_target(clngo rm -fv libhellogo.h)
add_custom_target(clnts rm -fv main.js main.js.map main.d.ts)

add_custom_target(clnapk WORKING_DIRECTORY "${projdir}/build"
    COMMAND rm -fv build/android-build/helloworld.apk build/android-build/build/outputs/apk/debug/android-build-debug.apk)
