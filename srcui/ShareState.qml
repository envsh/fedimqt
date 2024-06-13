// pragma singleton
// qml的singleton很难用啊.

import QtQml
import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Material
import QtQuick.Layouts

import "../main.js" as Lib;

// not work
// QtObject {
//     property string pt1 : "pt1val"
//     property int pt2  : 12345
//     property map sndmsgpfxs : {"dftim": "", "gptcf": "", "cmd": "!", }
// }

// not work
// property string foo: "fooprop"

Item {
    width:0
    height:0

    id: vss
    readonly property string foo: "fooprop"
    readonly property string bkdretpromis: "Promis<String>"
    // property list<string> sndmsgpfxkeys : ["dftim", "gptcf", "cmd"] // {"dftim": "", "gptcf": "", "cmd": "!", }
    // why no length/count methods???
    readonly property var sndmsgpfxs: {"dftim":"dftimpfx", "gptcf":"gptcfpfx", "cmd":"!"}

    function getsndmsgpfx(name) {
        Lib.debug("vss", vss.sndmsgpfxs, Lib.tojson(vss.sndmsgpfxs));
        return vss.sndmsgpfxs[name];
    }
    function trimsndmsgpfx(name, msg) {
        Lib.debug("vss", vss.sndmsgpfxs);
        let pfx = vss.sndmsgpfxs[name];
        if (pfx != '' && msg.startsWith(pfx)) {
            return msg.substring(pfx.length);
        }
        return msg;
    }

    Component.onCompleted: {
        // Lib.debug("chkmappp", JSON.stringify(vss.sndmsgpfxs));
        // assert check
        if (vss.getsndmsgpfx("dftim") != vss.sndmsgpfxs.dftim) {
            Lib.warn("maybe some error", JSON.stringify(vss.sndmsgpfxs));
        }
    }
}