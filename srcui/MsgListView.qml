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
// import QmlCppBridge 1.0 //

// import "srcui"

// import js now, from tspp/main.js
import "../main.js" as Lib;

// ApplicationWindow {
Rectangle {
    id: topwin
    // width: 500
    width: parent.width
    height: 580
    color: Material.background

ScrollView {
    ////////////
    visible: true
    width: parent.width
    height: parent.height-msgsndbar.height
    id: scroll1

    // color: "#010101"

    // Material.theme: Material.Dark
    // Material.accent: Material.Purple
    // Material.foreground : "red"

    //////

        // anchors.fill: parent
        // anchors.bottom : window.bottom-90
        // anchors.top: window.top
        // width : parent.width
        // Layout.fillWidth : true
        // id:scoll1
        // height: window.height-90
        // height: window.height-80
        

    ListView {
        id: listView
        anchors.fill: parent
        width : parent.width
        anchors.leftMargin: 5
        

        // todo 这个会覆盖Text的 linkActived 信号
        // MouseArea {
        //     anchors.fill: parent
        //     acceptedButtons: Qt.LeftButton | Qt.RightButton
        //     Menu {
        //         id: contextMenu
        //         MenuItem { text: "Cut" }
        //         MenuItem { text: "Copy" }
        //         MenuItem { text: "Paste" }
        //     }
        //     onClicked:  function (mouse) {
        //         // Lib.debug("maclick", mouse, JSON.stringify(mouse));
        //         // console.log(mouse); // QQuickMouseEvent
        //         if (mouse.button === Qt.RightButton) {
        //             contextMenu.popup();
        //         }
        //     }
        // }

        model: HelloModel{}
        delegate: Rectangle {
            id: grid
            // anchors.fill: parent
            // width: 350
            // width: parent.width
            width: listView.width
            border.width: 1
            // border.color: "#5a5a5a"
            color: Material.background

        
            // Rectangle {
                Layout.fillWidth: true
                // color: "gray"
                height: 30 + txtcc2.height + 30
                // height: 90

                RowLayout{
                    anchors.right : parent.right
                    anchors.left : parent.left
                    id: msgrow1
                    height: 32
                // Button {
                //     id: inbtn
                //     text:"tbn1"
                //     flat: true
                //     // anchors.right: parent.right
                // }
                Rectangle{
                    width: 120
                    opacity: 0.8
                MyText {
                    width: parent.width
                    id: inbtn
                    text: Sender
                    tiptext: 'sender:'+Sender
                    // text: "hhhh"
                    // color: Material.foreground
                    // elide: Text.ElideMiddle
                    // maximumLineCount: 1
                    // width: 120
                    // wrapMode: Text.WrapAnywhere
                }}
                // Rectangle {
                //     Layout.fillWidth:true
                //     Layout.horizontalStretchFactor : 30
                //     // Layout.preferredWidth : 567
                //     color: "gray"
                //     height: 1
                // }
                Rectangle{
                    width: 120
                    opacity: 0.65

                MyText {
                    id: lbroomname
                    text: Roomname==''?'Roomname':Roomname
                    tiptext: 'roomname:'+Roomname
                    width: 120
                    
                }} 
                Rectangle{
                    Layout.fillWidth: true
                    opacity: 0.65

                MyText {
                    id: lbroomid
                    text: Roomid==''?'Roomid':Roomid
                    tiptext: 'roomid:'+Roomid
                    width: 120
                    
                }}

                // Button {
                //     id: inbtn2
                //     text:"tbn2"
                //     height: 15
                //     flat: true
                // }
                Rectangle{
                    width: 120
                    opacity: 0.5

                MyText {
                    id: inbtn3
                    text: Mtimems
                    tiptext: 'mtimems:'+Mtimems
                    // flat: true
                    width: 120
                }
                }
                }

                    Rectangle {
                        Layout.fillWidth: true
                        anchors.top : msgrow1.bottom
                        // width:350
                        width: parent.width-6
                        height: txtcc.contentHeight
                        // color: "#505050"
                        // color: window.color
                        color: Material.background
                        border.width: 3
                        // border.color: "#999"
                        id: txtcc2
                        

                    MsgText {
                        id: txtcc
                        textFormat: txtccfmt
                        text: Content!=''?Content:'Content here'
                    }
                    }

                RowLayout {
                    anchors.top : txtcc2.bottom
                    width: parent.width
                    height: 30
                    Rectangle{
                        width:120
                        opacity: 0.5
                    // height: 30
                    // color: "red"

                    MyText {
                        text: "fedisite link"
                        tiptext: "full fedisite link"
                    }  }
                Rectangle{
                    width:90
                    opacity: 0.5
                    Layout.fillWidth: true
                    // height: 30
                    // color: "red"
                MyText {
                    id: labevtid
                    text: Eventid==''?"Eventid here":Eventid;
                    tiptext: Eventid
                    // width: 120 
                    // color: "red"
                    anchors.right : parent.right
                    anchors.left : parent.left
                }}
                // Dtime
                Rectangle{
                    width:120
                    opacity: 0.5
                    // height: 30
                    // color: "red"
                MyText {
                    id: labdtime
                    text: Dtime==''?"Dtime":Dtime
                    tiptext: 'dtime:'+Dtime
                    width: 120                    
                }}       
            }
            
        }
    
        onContentYChanged: {
            // Lib.debug(contentY, height, contentHeight)
            if (contentY + height >= contentHeight) {
                // if (model.canFetchMore()) {
                    // model.fetchMore();
                // }
            }
        }
        // boundsBehavior: Flickable.DragAndOvershootBounds
        onDragStarted:  {
            let sbv = scroll1.ScrollBar.vertical;
            // Lib.debug("drag start", listView.verticalOvershoot, listView.draggingVertically);
        }
        onDragEnded: {
            let sbv = scroll1.ScrollBar.vertical;
            // Lib.debug("drag end", listView.verticalOvershoot, listView.draggingVertically);
            if (listView.verticalOvershoot < -6.0) {
                Lib.info("fetch more triggered", listView.verticalOvershoot);
                logui.addlog("fetch more triggered " + listView.verticalOvershoot);
            } else if (listView.verticalOvershoot > 16.0) {
                Lib.info("refresh latest triggered", listView.verticalOvershoot);
            }

        }
        onMovementEnded: {
            let sbv = scroll1.ScrollBar.vertical;
            // Lib.debug("drag end", sbv.position, sbv.size);
        }
        onMovementStarted: {
            let sbv = scroll1.ScrollBar.vertical;
            // Lib.debug("drag end", sbv.position, sbv.size);
        }
    }


}
    // msgsendbar
    Rectangle {
        id: msgsndbar
        width: parent.width
        height: 60
        color: "blue"
        anchors.top : scroll1.bottom

        RowLayout {
            anchors.left : parent.left
            anchors.right : parent.right

            MyButton{ text:"SIMG"}
            TextArea {
                placeholderText: qsTr("Enter message")
                id: usriptmsg
                topPadding: 8
                bottomPadding: 5
                wrapMode: TextEdit.WrapAnywhere
                Layout.horizontalStretchFactor: 99
                Layout.fillWidth: true
                implicitWidth: 120
            }
            MyButton{ text:"Sendit!!!"; onClicked: sendmsg()}
            MyComboBox {       
                id: msgsndmode 
                model: ["dftim", "gptcf", "cmd", "misskey", "gptoa", "nostr"]
            }
        }
    }

    ///////// script

    // all functions are qt slots   

    Component.onCompleted: {
        // let rv = qcffi.invoke("thisqml");
        // Lib.debug(rv);
        listView.model.dummy()
        listView.model.append({name:"frommainqml", number: "frommainqml 909 545"})

        Lib.dummy('wt')
        Lib.util.dummy();
        // Jlib.default.dummy(); // TypeError: Cannot call method 'dummy' of undefined
        let m1 = new Map();
        Lib.debug("m1", m1);
    }
    //////
    function msgaddnodup(item, prepend) {
        let has = sss.msgs.has(item.Eventid);
        if (!has) {
            sss.msgs.set(item.Eventid, item);
            if (prepend) {
                listView.model.insert(0, item);
            }else{
                listView.model.append(item);
            }
            return true;
        }
        // Lib.debug('item', !has, item.Eventid, sss.msgs.size, listView.model.count);
        return false;
    }
    function  onloadmsg () {
            Lib.debug('clicked');
            let req = Lib.tojson({Cmd: "loadmsg", Argv:["1=1 limit 300"]});
            let resp = qcffi.invoke(req);
            Lib.debug('resplen', resp.length);
            let jso = JSON.parse(resp);
            Lib.debug("rowcnt", jso.Retc, jso.Retv.length);
            for (let i=0; i < jso.Retc; i++) {
                let rv = jso.Retv[i];
                // let item = {name:"", number: ""};
                let item = rv;
                item.name = rv.Sender;
                item.number = rv.Roomid;
                listView.model.insert(0, item);
                for (let j=0;j < 30; j++) {
                    // listView.model.insert(0, item);
                }
                // listView.model.append({name:"frommainqml", number: "frommainqml 909 545"})
                // Lib.debug('typeof', typeof rv.Sender)
            }
            Lib.debug('itemcnt', listView.model.count);
    }
    function fetchmore() {
        let fmcond = sss.fetchmore_condstr();
            Lib.debug('...', sss.fmnext_batch, fmcond);
            let req = Lib.tojson({Cmd: "loadmsg", Argv:[fmcond]});
            // if (true) return;
            let resp = qcffi.invoke(req);
            assert(resp == sss.bkdretpromis, 'error invoke', req);
            // Lib.debug('resplen', resp.length);
            // let jso = JSON.parse(resp);
            // Lib.debug("rowcnt", jso.Retc, jso.Retv.length);
            // for (let i=0; i < jso.Retc; i++) {
            //     let rv = jso.Retv[i];
            //     // let item = {name:"", number: ""};
            //     let item = rv;
            //     item.name = rv.Sender;
            //     item.number = rv.Roomid;
            //     listView.model.insert(0, item);
            //     for (let j=0;j < 30; j++) {
            //         // listView.model.insert(0, item);
            //     }
            //     // listView.model.append({name:"frommainqml", number: "frommainqml 909 545"})
            //     // Lib.debug('typeof', typeof rv.Sender)
            // }
            // Lib.debug('itemcnt', listView.model.count);
    }
    function loadmsgret(retv) {
        Lib.debug("...rowcnt", retv.length);
        let oldcnt = listView.model.count;
        for (let i=retv.length-1; i >= 0; i--) {
            let rv = retv[i];
            // let item = {name:"", number: ""};
            let item = sss.newFediRecord();
            item.Dtime = rv.Dtime == '' ? rv.dtime : rv.Dtime;
            item.name = item.Sender = "gptcfai"
            item.Feditype = "gptcf"
            item.Roomid = "mainline@cf"
            item.Roomname = "mainline"
            item.Eventid = "$ifsf"
            item.name = rv.Sender;
            item.number = rv.Roomid;
            item.Eventid = rv.Eventid;
            item = rv;
            item.Dtime = '0s0ms';
            // listView.model.insert(0, item);
            msgaddnodup(item, true);
            for (let j=0;j < 30; j++) {
                    // listView.model.insert(0, item);
            }
            // listView.model.append({name:"frommainqml", number: "frommainqml 909 545"})
            // Lib.debug('typeof', typeof rv.Sender)

            // listView.model.insert(0, item);
            let ok = msgaddnodup(item, true);
            sss.setnextbatch(item.Mtimems);
            // Lib.debug(i, ok, item.Eventid);
        }
        let addcnt = listView.model.count - oldcnt;
        if (addcnt>0) {
            scrollvto(true);
        }
        Lib.debug('itemcnt',  addcnt, listView.model.count);
    }

    function sendmsg() {
        // Lib.debug("sss", sss.foo, sss.getsndmsgpfx("dftim"), JSON.stringify(sss.barz));
        // return;

        let sndmode = msgsndmode.currentValue;
        let msgpfx = sss.getsndmsgpfx(sndmode);
        let msg = usriptmsg.text;
        msg = msgpfx + msg;
        Lib.debug("usriptmsg", msg.length, sndmode, msg);

        let req = Lib.tojson({Cmd: "sendmsg", Argv:[sndmode, msg]});
        let resp = qcffi.invoke(req); // todo: will freeze ui
        Lib.debug("resp", resp);
        if (false) { // async mode, no result data here
            let jso = JSON.parse(resp);
            let item = {Content: jso.Retv[0]};
            listView.model.insert(0, item);
        }
    }
    function sendmsgret(rv) {
        let item = {Content: rv.content};
        item.Dtime = rv.Dtime == '' ? rv.dtime : rv.Dtime;
        item.name = item.Sender = "gptcfai";
        item.Feditype = "gptcf";
        item.Roomid = "mainline@cf";
        item.Roomname = "mainline";
        item.Eventid = rv.Eventid!=''? rv.Eventid : "$ifsf";
        
        // listView.model.insert(0, item);
        msgaddnodup(item, false);
    }


    function scrollvto(top : bool) {
        // 0.0 - 1.0
        let sbv = scroll1.ScrollBar.vertical;
        if (top) {
            sbv.position = 0.0;
        }else{
            // Lib.debug("nowpos", sbv.position);
            sbv.position = 1.0 - sbv.size // scroll1.contentHeight - scroll1.height;
            // Lib.debug("cch", scroll1.contentHeight, "winh", scroll1.height);
        }
    }

    property int txtccfmt: Text.MarkdownText
    function setccfmt(f) { txtccfmt  = f }

    // async function dummy() {} // not work syntax error
}
