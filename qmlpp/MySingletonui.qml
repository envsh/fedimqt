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

    // 二分查找add
    // mdl 是 qml ListModel
    function msgaddinorder(mdl, item) {
        let cnt = mdl.count;
        let inspos = -1;
        // Tspp.debug("addio", item.Mtimems, cnt);

        if (cnt == 0) {
            mdl.append(item);
            return;
        }

        let item0 = mdl.get(0);
        let itemx = mdl.get(cnt-1);
        if (item.Mtimems <= item0.Mtimems) {
            inspos = 0;
        }else if (item.Mtimems >= itemx.Mtimems) {
            inspos = cnt;
            // mdl.append(item);
            // return;
        }else{
            let start = 0;
            let end = cnt;
            for (let i=0; i < 10000; i++) {
                let pos = Math.floor((start+end)/2);
                // Tspp.debug('pos', pos, i);
                item0 = mdl.get(pos-1);
                itemx = mdl.get(pos);
                if (item.Mtimems>=item0.Mtimems && item.Mtimems<=itemx.Mtimems) {
                    inspos = pos;
                    // Tspp.debug("find times:", i, cnt);
                    break;
                }else if (item.Mtimems<item0.Mtimems) {
                    end = pos;
                }else if (item.Mtimems>itemx.Mtimems) {
                    start = pos;
                } else {
                    Tspp.debug("how to do then", pos, cnt, item.Mtimems, item0.Mtimems, itemx.Mtimems);
                }
            }
        }
        // Tspp.debug("found inspos", inspos, cnt);
        mdl.insert(inspos, item);

            // if (prepend) {
            //     listView.model.insert(0, item);
            // }else{
            //     listView.model.append(item);
            // }

    }
    function msgaddnodup(item, prepend) {
        let has = Sss.msgs.has(item.Eventid);
        if (!has) {
            Sss.msgs.set(item.Eventid, true);
            msgaddinorder(listView.model, item);
            return true;
        }
        // Tspp.debug('item', !has, item.Eventid, Sss.msgs.size, listView.model.count);
        return false;
    }

    // general, for msglst and loglst
    function scrollvto(scrobj, top : bool, dirvert: bool) {
        // Tspp.debug("top=", top);
        // 0.0 - 1.0
        let sbv = scrobj.ScrollBar.vertical;
        if (top) {
            sbv.position = 0.0;
        }else{
            // Tspp.debug("nowpos", sbv.position);
            sbv.position = 1.0 - sbv.size // scroll1.contentHeight - scroll1.height;
            // Tspp.debug("cch", scroll1.contentHeight, "winh", scroll1.height);
        }
    }

    /////
    function qmlTimer() {
        // return Qt.createComponent("import QtQuick; Timer{}", appwin);
        return Qt.createQmlObject("import QtQuick; Timer{}", appwin);
    }
    function qmlSetTimeout(cbfn, delay, ...args) {
        // console.log(cbfn, delay, ...args);
        let tmer = qmlTimer();
        tmer.interval = delay;
        tmer.repeat = true; // like origin setTimeout
        let cb = () => { cbfn(...args); };
        tmer.triggered.connect(cb);
        // tmer.running = true;
        tmer.start();
        return tmer
    }
    function qmlClearTimeout(tmer) {
        // console.log("clrtmer", tmer);
        // tmer.running = false;
        tmer.stop();
        // tmer.disconnect(); // not work
        tmer.destroy();
    }
}
