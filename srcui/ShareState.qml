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
    // some settings
    readonly property string fetchmsg_condstr_tmpl: "order by mtime desc limit 21, offset 0"
    property string fetchmsg_condstr : ""
    property int fetchmsg_pagenum : 31
    property int fetchmsg_pageno: 0
    property var fmnext_batch : Number.MAX_SAFE_INTEGER // history, unixts currently
    property var fmprev_batch : Number.MAX_SAFE_INTEGER // history, unixts currently

    //
    // readonly var starttime : (new Date()) // not work
    readonly property string foo: "fooprop"
    readonly property string bkdretpromis: "Promis<String>"
    // property list<string> sndmsgpfxkeys : ["dftim", "gptcf", "cmd"] // {"dftim": "", "gptcf": "", "cmd": "!", }
    // why no length/count methods???
    readonly property var sndmsgpfxs: {"dftim":"dftimpfx", "gptcf":"gptcfpfx", "cmd":"!"}
    property var m1tst : new Map()
    property var msgs : new Map() // msgid=>msgobj
    property var grps : new Map() // grpid=>grpobj

    // script section
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
        Lib.debug("m1tst", m1tst, Number.MAX_SAFE_INTEGER);
    }

    function fetchmore_condstr() {
        let nxtbt = fmnext_batch;
        let pnum = fetchmsg_pagenum;
        let pno = fetchmsg_pageno;
        let offs = pno*pnum;
        return  `mtimems<=${nxtbt} order by mtimems desc limit ${pnum} offset ${offs}`;
    }
    function setnextbatch(nxtbt) {
        if (nxtbt < fmnext_batch) {
            fmnext_batch = nxtbt;
        }
    }

    // type or class not work
    //class FediRecord {}; //
    function newFediRecord () {
        let obj = {
            name: "Bill Smith",
            number: "555 3264",
            Content: "",
            Roomid: "",
            Roomname: "",
            Feditype: "",
            Eventid: "",
            Sender: "",
            Mtimems: 0,
            Mtimemsui: '',
            Dtime: "0s0ms",
        };
        return obj;
    }
}
