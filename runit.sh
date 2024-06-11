function installallqmllib() {
    lst=`find ~/.nix-profile/lib/qt-6/qml/ -name "*dylib"`
    # echo $lst
    for lib in $lst; do
        echo "$lib"
        cp -v "$lib" ./platformsthemes/
    done
}

# installallqmllib;
# exit;

export DYLD_LIBRARY_PATH=$PWD/

    # DYLD_PRINT_LIBRARIES=1 \
    # LD_LIBRARY_PATH=~/.nix-profile/lib/qt-6:./plugins/ \
    # DYLD_LIBRARY_PATH=~/.nix-profile/lib/qt-6:./plugins/ \
    # QT_PLUGIN_PATH=./plugins/  \
    #QT_DEBUG_PLUGINS=1 \
    # DYLD_LIBRARY_PATH=$PWD/ \
export QML_IMPORT_PATH=~/.nix-profile/lib/qt-6/qml/

export QT_QUICK_CONTROLS_STYLE=Material
export QT_QUICK_CONTROLS_MATERIAL_THEME=Dark

./helloworld.app/Contents/MacOS/helloworld

# the QML_IMPORT_PATH line works
# or error like this: module "QtQuick.Controls" plugin "qtquickcontrols2plugin" not found
