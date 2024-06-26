pragma Singleton;
// qml的singleton很难用啊.

import QtQml
import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Material
import QtQuick.Layouts

// import "../main.js" as Lib;
import "../qmlpp"

// not work
// QtObject {
//     property string pt1 : "pt1val"
//     property int pt2  : 12345
//     property map sndmsgpfxs : {"dftim": "", "gptcf": "", "cmd": "!", }
// }

// 只存放无法移植到 go 的属性值
QtObject {
    id: vss
    // some settings
    // readonly property string fetchmsg_condstr_tmpl: "order by mtime desc limit 21, offset 0"
    // property string fetchmsg_condstr : ""
    // property int fetchmsg_pagenum : 31
    // property int fetchmsg_pageno: 0
    // property var fmnext_batch : Number.MAX_SAFE_INTEGER // history, unixts currently
    // property var fmprev_batch : Number.MAX_SAFE_INTEGER // history, unixts currently

    //
    // readonly property string foo: "fooprop"
    // readonly property string bkdretpromis: "Promis<String>"
    // why no length/count methods???
    // readonly property var sndmsgpfxs: {"dftim":"dftimpfx： ", "gptcf":"请使用中文完成对话：", "cmd":"!"}
    // property var m1tst : new Map()
    // property var msgs : new Map() // msgid=>msgobj
    // property var grps : new Map() // grpid=>grpobj
    property var dftft: null // should be font object

    // property int olnchkerrcnt : 0
    // property string olnchkerrmsg : '';

    // script section
    // function getsndmsgpfx(name) {
    //     Tspp.debug("vss", vss.sndmsgpfxs, Tspp.tojson(vss.sndmsgpfxs));
    //     return vss.sndmsgpfxs[name];
    // }
    // function trimsndmsgpfx(name, msg) {
    //     Tspp.debug("vss", vss.sndmsgpfxs);
    //     let pfx = vss.sndmsgpfxs[name];
    //     if (pfx != '' && msg.startsWith(pfx)) {
    //         return msg.substring(pfx.length);
    //     }
    //     return msg;
    // }

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

        // assert check
        // if (vss.getsndmsgpfx("dftim") != vss.sndmsgpfxs.dftim) {
        //     Tspp.warn("maybe some error", JSON.stringify(vss.sndmsgpfxs));
        // }
        // Tspp.debug("m1tst", m1tst, Number.MAX_SAFE_INTEGER);
    }

    // function fetchmore_condstr() {
    //     let nxtbt = fmnext_batch;
    //     let pnum = fetchmsg_pagenum;
    //     let pno = fetchmsg_pageno;
    //     let offs = pno*pnum;
    //     return  `mtimems<=${nxtbt} order by mtimems desc limit ${pnum} offset ${offs}`;
    // }
    // function setnextbatch(nxtbt) {
    //     if (nxtbt < fmnext_batch) {
    //         fmnext_batch = nxtbt;
    //     }
    // }

    // type or class not work
    //class FediRecord {}; //
    // function newFediRecord () {
    //     let obj = {
    //         name: "Bill Smith",
    //         number: "555 3264",
    //         Content: "",
    //         Roomid: "",
    //         Roomname: "",
    //         Feditype: "",
    //         Eventid: "",
    //         Sender: "",
    //         Mtimems: 0,
    //         Mtimemsui: '',
    //         Dtime: "0s0ms",
    //     };
    //     return obj;
    // }

    // function onolnchkerr(Argv) {
    //     let msg = Argv[1];
    //     if (msg == Sss.olnchkerrmsg) {
    //         Sss.olnchkerrcnt += 1;
    //     }else{
    //         Sss.olnchkerrmsg = msg;
    //         Sss.olnchkerrcnt = 1;
    //     }
    //     // upstatusll(msg + ' ' + Sss.olnchkerrcnt);
    //     // Tspp.debug(msg, Sss.olnchkerrcnt);
    //     let ret = msg + ' ' + Sss.olnchkerrcnt;
    //     return ret;
    // }
}
