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
add_custom_target(tscc
    # COMMAND "tsc" "-v"
    COMMAND "tsc" "--pretty" "--sourceMap" "--declaration" "--module" "commonjs" "--lib" "es2020,dom" "--esModuleInterop" "${CMAKE_HOME_DIRECTORY}/main.ts"
    # fix https://stackoverflow.com/questions/43042889/typescript-referenceerror-exports-is-not-defined
    COMMAND "sed" "-i" ".bak" "'s/\"use strict\";/var exports = {};\\n\\n\"use strict\";/g'" "${CMAKE_HOME_DIRECTORY}/main.js"
    SOURCES main.ts)
add_dependencies(helloworld tscc)

add_custom_target(gocc
    WORKING_DIRECTORY "${CMAKE_HOME_DIRECTORY}/srcgo"
    COMMAND pwd && go version
    COMMAND go build -buildmode=c-shared -o ../libhellogo${shextsfx} ./
    COMMAND ls -lh ../libhellogo${shextsfx} && file ../libhellogo${shextsfx}
    # COMMAND cp main ../libhellogo.so
    # SOURCES ./srcgo/*.go ./srcgo/go.*
    # COMMAND_EXPAND_LISTS
)
add_dependencies(helloworld gocc)

