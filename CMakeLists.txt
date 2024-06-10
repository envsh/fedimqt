cmake_minimum_required(VERSION 3.16)

project(helloworld VERSION 1.0.1 LANGUAGES CXX C)


set(CMAKE_C_STANDARD 99)
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_FLAGS "-g -ggdb -O0")
set(CMAKE_VERBOSE_MAKEFILE true)
set(CMAKE_CXX_EXTENSIONS off)

find_package(Qt6 REQUIRED COMPONENTS Core)
find_package(Qt6 REQUIRED COMPONENTS Widgets)
# declaretive
find_package(Qt6 REQUIRED COMPONENTS Qml)
find_package(Qt6 REQUIRED COMPONENTS QmlIntegration)
find_package(Qt6 REQUIRED COMPONENTS Quick)
find_package(Qt6 REQUIRED COMPONENTS QuickControls2)
qt_standard_project_setup()


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


target_link_libraries(helloworld PRIVATE Qt6::Widgets Qt6::Qml Qt6::QmlIntegration Qt6::Quick Qt6::QuickControls2)

set_target_properties(helloworld PROPERTIES
    WIN32_EXECUTABLE ON
    MACOSX_BUNDLE ON
    # QT_QML_ROOT_PATH ""
    # QT_QML_IMPORT_PATH "~/.nix-profile/lib/qt-6/qml/"
)
