// Copyright (C) 2018 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause

import QtQml
import QtQml.WorkerScript
import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Material
import QtQuick.Layouts
import QtQuick.Window

/////
import QmlCppBridge 1.0 //

import "srcui"

// import js now, from tspp/main.js
import "main.js" as Lib;

ApplicationWindow {

    ////////////
    id: appwin
    width: 500
    height: 650
    visible: true
    // color: "#010101"

    Material.theme: Material.Dark
    // Material.accent: Material.Purple
    // Material.foreground : "red"

    /////
    menuBar: MenuBar {
        Menu {
            title: qsTr("&File")
            Action { text: qsTr("&New...") }
            Action { text: qsTr("&Open...") }
            Action { text: qsTr("&Save") }
            Action { text: qsTr("Save &As...") }
            MenuSeparator { }
            Action { text: qsTr("&Quit") }
        }
        Menu {
            title: qsTr("&Edit")
            Action { text: qsTr("Cu&t") }
            Action { text: qsTr("&Copy") }
            Action { text: qsTr("&Paste") }
        }
        Menu {
            title: qsTr("&Window")
            Action { text: qsTr("&Next Page >") ; onTriggered: switchpage(false)}
            Action { text: qsTr("&Prev Page >") ; onTriggered: switchpage(true) }
            Action { text: qsTr("Cu&t") }
            Action { text: qsTr("&Copy") }
            Action { text: qsTr("&Paste") }
        }
        Menu {
            title: qsTr("&Dev")
            Action { text: qsTr("&Load Message") ; onTriggered: onloadmsg() }
            Action { text: qsTr("&Copy") }
            Action { text: qsTr("&Paste") }
        }
        Menu {
            title: qsTr("&Misc")
            Action { text: qsTr("Cu&t") }
            Action { text: qsTr("&Copy") }
            Action { text: qsTr("&Paste") }
        }
        Menu {
            title: qsTr("&Help")
            Action { text: qsTr("&About") }
        }
    }

    ///////
    // header: ToolBar {
    //     RowLayout {
    //         anchors.fill: parent
    //         ToolButton {
    //             text: qsTr("‹")
    //             onClicked: stack.pop()
    //         }
    //         Label {
    //             text: "Title"
    //             elide: Label.ElideRight
    //             horizontalAlignment: Qt.AlignHCenter
    //             verticalAlignment: Qt.AlignVCenter
    //             Layout.fillWidth: true
    //         }
    //         ToolButton {
    //             text: qsTr("⋮")
    //             onClicked: menu.open()
    //         }
    //     }
    // }

    /// center content
    StackView {
        id: stackwin
        // anchors.fill: parent
        width : parent.width
        height : parent.height-30

        initialItem: msglstwin
        property list<Item> childs: [msglstwin, romlstwin, loginui, logui, aboutui]
        property int curidx : 0
        

        Aboutui{ id: aboutui }
        Logui {id: logui}
        Loginui { id: loginui }
        RoomListView { id: romlstwin }
        MsgListView{id: msglstwin}
        // Rectangle { anchors.fill : parent;  color: "red" } // clear

        Component.onCompleted: {
            Lib.debug("stkwin done");
            // stackwin.push(aboutui);
            // stackwin.push(msglstwin);
        }
    }

    Rectangle {
        color: "darkgreen"
        // height: inbtn.height
        height: 38
        width: parent.width
        anchors.top: stackwin.bottom// + 3
    }

    ///////// script
    QmlCppBridge {    id : qcffi }

    // all functions are qt slots   
    function oncallqml(str) {
        Lib.debug(str);
        // Lib.info("lstcnt", listView.count);  // print ui object property
    }

    Component.onCompleted: {
        let rv = qcffi.invoke("thisqml");
        Lib.debug(rv);
        // listView.model.dummy()
        // listView.model.append({name:"frommainqml", number: "frommainqml 909 545"})

        Lib.dummy('wt')
        Lib.util.dummy();
        // Jlib.default.dummy(); // TypeError: Cannot call method 'dummy' of undefined
    }
    //////
    // var pageitems = [aboutui,msglstwin];
    function switchpage(prev : bool) {
        let stkwin = stackwin;
        Lib.debug("prev", prev, stkwin.depth, stkwin.curidx, stkwin.childs.length);
        // stackwin.index = -1; // non-exist???
        let nxtidx = stkwin.curidx + ( prev ? -1: 1);
        if (nxtidx < 0) nxtidx = stkwin.childs.length;
        if (nxtidx >= stkwin.childs.length) nxtidx = 0;
        Lib.debug("switpage", stkwin.curidx, "=>", nxtidx);
        stkwin.curidx = nxtidx;

        let curitem = stkwin.currentItem;
        stkwin.replace(curitem, stkwin.childs[nxtidx]);
        
        stkwin.find(function(item, index) {
            Lib.debug('idx', index);
            // return item.isTheOne
            return false;
        }, StackView.DontLoad);
    }
    function switchpageidx(idx : int) {
        let curitem = stkwin.currentItem;
        let nxtidx = idx;
        let nxtitem = stkwin.childs[nxtidx];
        stkwin.curidx = nxtidx;
        stkwin.replace(curitem, nxtitem);
    }

    function  onloadmsg () {
        msglstwin.onloadmsg();
    }
    // function  onloadmsg () {
    //         Lib.debug('clicked');
    //         let req = Lib.tojson({Cmd: "loadmsg", Argv:["1=1 limit 300"]});
    //         let resp = qcffi.invoke(req);
    //         Lib.debug('resplen', resp.length);
    //         let jso = JSON.parse(resp);
    //         Lib.debug("rowcnt", jso.Retc, jso.Retv.length);
    //         for (let i=0; i < jso.Retc; i++) {
    //             let rv = jso.Retv[i];
    //             // let item = {name:"", number: ""};
    //             let item = rv;
    //             item.name = rv.Sender;
    //             item.number = rv.Roomid;
    //             listView.model.insert(0, item);
    //             for (let j=0;j < 30; j++) {
    //                 // listView.model.insert(0, item);
    //             }
    //             // listView.model.append({name:"frommainqml", number: "frommainqml 909 545"})
    //             // Lib.debug('typeof', typeof rv.Sender)
    //         }
    //         Lib.debug('itemcnt', listView.model.count);
    //     }
}