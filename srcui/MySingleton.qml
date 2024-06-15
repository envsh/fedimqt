pragma Singleton
// qml的singleton很难用啊.

import QtQml
import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Material
import QtQuick.Layouts

import "../main.js" as Lib;

// \see qmldir file:
// module mainqml
// singleton MySingleton 1.0 MySingleton.qml

// work
QtObject {
    property string pt1 : "pt1val"
    property int pt2  : 12345
    readonly property var sndmsgpfxs: {"dftim":"dftimpfx： ", "gptcf":"请使用中文完成对话：", "cmd":"!"}

    // release
    readonly property var starttime: new Date()
    readonly property string bkdretpromis: "Promis<String>"
    readonly property bool isapk : Qt.platform.os == "android"
    readonly property bool isosx : Qt.platform.os == "osx"
    readonly property bool islinux : Qt.platform.os == "linux"
    readonly property bool isunix : Qt.platform.os == "unix"

    function dummy() {
        Lib.debug(pt1, pt2);
    }
    function initsome() {
        Lib.debug(pt1, pt2);
    }
}
// Lib.debug('works???', pt1, pt2); // not work
// 不能和 Item {} 这种声明组合使用
