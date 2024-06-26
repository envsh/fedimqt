pragma Singleton
// qml的singleton很难用啊.

import QtQml
import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Material
import QtQuick.Layouts

// import "../main.js" as Lib;

// \see qmldir file:
// module mainqml
// singleton MySingleton 1.0 MySingleton.qml

// work


Item {


// 在外部引用不到，MySingletonui.objs
QtObject {
    id: objs
    property string pt1 : "pt1val"
    property int pt2  : 12345
    property var sndmsgpfxs : {"dftim": "", "gptcf": "", "cmd": "!", }

    // release
    readonly property var starttime: new Date()
    readonly property string bkdretpromis: "Promis<String>"

    // 这种声明只能在，只能在内部使用？？？
    // 这儿就不能声明方法/函数
    // Cannot call method 'dummy' of undefined
    function dummy() {
        Lib.debug(pt1, pt2);
    }
}

    // script
    Component.onCompleted: {
        Lib.debug('works???', objs.pt1, objs.pt2); // not work
        MySingleton.dummy();
        MySingleton.initsome();
    }

    function dummy() {
        Lib.debug(objs.pt1, objs.pt2);
        objs.dummy();
    }

}
