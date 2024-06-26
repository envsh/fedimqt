pragma Singleton;
// qml的singleton很难用啊.

import QtQml
import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Material
import QtQuick.Layouts

// import "../main.js" as Lib;
// import "../qmlpp"

// not work
// QtObject {
//     readonly property string foo: "fooprop"
//     property string pt1 : "pt1val"
//     property int pt2  : 12345
//     property map sndmsgpfxs : {"dftim": "", "gptcf": "", "cmd": "!", }
// }

// 只存放无法移植到 go 的属性值
QtObject {
    id: vss
    // some settings
    //
    // why no length/count methods???
    // property var m1tst : new Map()
    // property var msgs : new Map() // msgid=>msgobj
    // property var grps : new Map() // grpid=>grpobj
    property var dftft: null // should be font object

    // script section
    Component.onCompleted: {
        // Tspp.debug("");
        // Tspp.debug("why not run here???");
        onCompleted2();
    }
    function onCompleted2() {
        // Tspp.debug("chkmappp", JSON.stringify(vss.sndmsgpfxs));
        let txtobj = Qt.createQmlObject('import QtQuick; Text{}', vss);
        // Tspp.debug("fly txtobj", txtobj, txtobj.font);
        vss.dftft = txtobj.font;
        txtobj.destroy();
    }
}
