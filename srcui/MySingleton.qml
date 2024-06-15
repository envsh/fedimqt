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
    property var sndmsgpfxs : {"dftim": "", "gptcf": "", "cmd": "!", }

    // release
    readonly property var starttime: new Date()
    readonly property string bkdretpromis: "Promis<String>"

    function dummy() {
        Lib.debug(pt1, pt2);
    }
    function initsome() {
        Lib.debug(pt1, pt2);
    }
}
// Lib.debug('works???', pt1, pt2); // not work
// 不能和 Item {} 这种声明组合使用
