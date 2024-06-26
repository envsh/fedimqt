

import QtQml
import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Material
import QtQuick.Layouts


// Rectangle {}
// Text 
// Button
// QtObject { }

Item{

    // general, for msglst and loglst
    // scrobj ScrollView
    function scrollvto(scrobj, top : bool) {
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
