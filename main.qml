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
            Action { text: qsTr("Logui"); onTriggered: switchpageidx(3) }
            Action { text: qsTr("&Aboutui"); onTriggered: switchpageidx(4) }
            Action { text: qsTr("&Romm List"); onTriggered: switchpageidx(1) }
            Action { text: qsTr("&Loginui"); onTriggered: switchpageidx(2) }
            Action { text: qsTr("&Message List"); onTriggered: switchpageidx(0) }
        }
        Menu {
            title: qsTr("&Dev")
            Action { text: qsTr("&Load Message") ; onTriggered: onloadmsg() }
            Action { text: qsTr("&Load More Older"); onTriggered: msglstwin.fetchmore() }
            Action { text: qsTr("&AutoText"); 
                onTriggered: msglstwin.setccfmt(Text.AutoText) }
            Action { text: qsTr("&MarkdownText");
                onTriggered: msglstwin.setccfmt(Text.MarkdownText) }
            Action { text: qsTr("&RichText"); 
                onTriggered: msglstwin.setccfmt(Text.RichText) }
            Action { text: qsTr("&PlainText"); 
                onTriggered: msglstwin.setccfmt(Text.PlainText) }
        }
        Menu {
            title: qsTr("&Misc")
            Action { text: qsTr("Scroll Bottom"); 
                onTriggered: msglstwin.scrollvto(false) }
            Action { text: qsTr("Scroll Top");
                onTriggered: msglstwin.scrollvto(true) }
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
        

        Aboutui{ id: aboutui ; visible: false }
        Logui {id: logui; visible: false}
        Loginui { id: loginui; visible: false }
        RoomListView { id: romlstwin ; visible: false}
        MsgListView{id: msglstwin; visible: false}
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
    ShareState { id: sss}


    // all functions are qt slots   
    function oncallqml(jstr) {
        Lib.debug(jstr);
        // Lib.info("lstcnt", listView.count);  // print ui object property
        // try {
        let jso = JSON.parse(jstr);
        dispatchEvent(jso);
        // }catch(err) {
            // console.error(err, ":", jstr);
            // Lib.error(err, ":", jstr.length, jstr.substring(0, 56));
        // }
    }
    function dispatchEvent(jso) {
        switch (jso.Cmd) {
            case "notice":
                break;
            case "sendmsg":
                msglstwin.sendmsgret(jso.Retv[0]);
                break;
            case "loadmsg":
                msglstwin.loadmsgret(jso.Retv);
                break;

            default:
                break;
        }
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
        // Lib.debug("prev", prev, stkwin.depth, stkwin.curidx, stkwin.childs.length);
        // stackwin.index = -1; // non-exist???
        let nxtidx = stkwin.curidx + ( prev ? -1: 1);
        if (nxtidx < 0) nxtidx = stkwin.childs.length-1;
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
        let stkwin = stackwin;
        let curitem = stkwin.currentItem;
        let nxtidx = idx;
        let nxtitem = stkwin.childs[nxtidx];
        stkwin.curidx = nxtidx;
        Lib.debug(idx, "curitem", curitem, "nxtitem", nxtitem);
        stkwin.replace(curitem, nxtitem);
    }

    function  onloadmsg () {
        msglstwin.onloadmsg();
    }
}