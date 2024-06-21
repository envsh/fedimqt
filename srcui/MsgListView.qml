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

import "../qmlpp"

import ListModelBase // C++/Go implmention

// how singleton main.js???
// import js now, from tspp/main.js
// import "../main.js" as Lib;

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
        currentIndex: -1

        // context menu
        // 如果放在 delegate中，这种用法会生成很多 Menu 实例？？？
        Menu {
            id: contextMenu
            MenuItem { text: "Cut" }
            MenuItem { text: "Copy" }
            MenuItem { text: "Paste" }
        }
        // Rectangle {
        //     width: 300
        //     height: 50
        //     MyLabel {color: "red"; text:"nocontent"; visible: msglstmdl.count<=0}
        // }

        // model: HelloModel{id: msglstmdl}
    model: ListModelBase {
        // clazz: "msglstmdl" // 用来选择 roleNames 列表
        objectName: "msglstmdl" // 用来选择 roleNames 列表
        id: msglstmdl
    }
        delegate: Rectangle {
            id: grid
            // anchors.fill: parent
            // width: 350
            // width: parent.width
            width: listView.width
            // border.width: 1
            // border.color: "#5a5a5a"
            // color: Material.background
            property string bgcolor: index == listView.currentIndex ? "#4a4a4a" : Material.background
            color: bgcolor

            // todo 这个会覆盖Text的 linkActived 信号？？？
                MouseArea {
                    anchors.fill: parent
                    acceptedButtons: Qt.LeftButton | Qt.RightButton
                    onClicked: (evt) => {
                        let oldidx = listView.currentIndex;
                        if (evt.button === Qt.RightButton) {
                            contextMenu.popup();
                        }else{
                        listView.currentIndex = oldidx==index?-1:index;
                        // Tspp.debug('lstcuridx', oldidx, "=>", index);
                        }
                    }
                }

            // Rectangle {
                Layout.fillWidth: true
                // color: "gray"
                height: 30 + txtcc2.height + 30
                // height: 90

                RowLayout{
                    // anchors.fill: parent
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
                MyImage {source:"../icons/icon_avatar.png"; 
                    width:22; height:22; }
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
                    text: Mtimemsui==''?'Mtimems':Mtimemsui
                    tiptext: 'mtimems:'+Mtimems
                    // flat: true
                    width: 120
                    horizontalAlignment: Text.Right
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
                        // color: Material.background
                        color: grid.bgcolor
                        // border.width: 3
                        // border.color: "#999"
                        id: txtcc2
                        

                    MsgText {
                        // todo if text too long, folder it???
                        id: txtcc
                        textFormat: txtccfmt
                        text: Content!=''?Content:'Content here'
                    }
                    MyImage{source:"../icons/MessageListSending@2x.png"; width:15
                        anchors.right: txtcc.right;
                        anchors.bottom: txtcc.bottom;}
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
                    horizontalAlignment: Text.Right
                }}       
            }
            
        }
    
        onContentYChanged: {
            // Tspp.debug(contentY, height, contentHeight)
            if (contentY + height >= contentHeight) {
                // if (model.canFetchMore()) {
                    // model.fetchMore();
                // }
            }
        }
        // boundsBehavior: Flickable.DragAndOvershootBounds
        onDragStarted:  {
            let sbv = scroll1.ScrollBar.vertical;
            // Tspp.debug("drag start", listView.verticalOvershoot, listView.draggingVertically);
        }
        onDragEnded: {
            let sbv = scroll1.ScrollBar.vertical;
            // Tspp.debug("drag end", listView.verticalOvershoot, listView.draggingVertically);
            // todo android 上，这个值很大，大概很容易达到 +-200
            if (listView.verticalOvershoot < -6.0) {
                Tspp.info("fetch more older triggered", listView.verticalOvershoot);
                logui.addlog("fetch more older triggered " + listView.verticalOvershoot);
            } else if (listView.verticalOvershoot > 16.0) {
                Tspp.info("refresh latest triggered", listView.verticalOvershoot);
            }

        }
        onMovementEnded: {
            let sbv = scroll1.ScrollBar.vertical;
            // Tspp.debug("drag end", sbv.position, sbv.size);
        }
        onMovementStarted: {
            let sbv = scroll1.ScrollBar.vertical;
            // Tspp.debug("drag end", sbv.position, sbv.size);
        }
    }


}
    // msgsendbar
    Rectangle {
        id: msgsndbar
        width: parent.width
        height: 60
        // color: "blue"
        color: Material.background
        anchors.top : scroll1.bottom

        RowLayout {
            anchors.left : parent.left
            anchors.right : parent.right

            MyButton{ text:"SIMG"; implicitWidth: 32;
                tiptext: qsTr("Select and send Photo/File(s)")
                display: AbstractButton.IconOnly
                icon.source: "../icons/add.png"}

            TextArea {
                // TODO 不要在编辑的时候在上边显示提示
                placeholderText: (!focus && text=='') ? qsTr("Enter message") : ''
                // preeditText: qsTr("Enter message")
                id: usriptmsg
                topPadding: 8
                bottomPadding: 5
                wrapMode: TextEdit.WrapAnywhere
                Layout.horizontalStretchFactor: 99
                Layout.fillWidth: true
                implicitWidth: 120
                // background: Rectangle {
                //     color: Material.background
                //     // implicitWidth: 200
                //     // implicitHeight: 40
                //     // border.color: control.enabled ? "#21be2b" : "transparent"
                //     // border.color: "transparent"
                // }

                onEditingFinished: ()=>{ Tspp.debug("iptedfin") }
                // Keys.onEnterPressed: ()=>{ Tspp.debug("iptetpr") }
                Keys.onReturnPressed: (ke)=>{
                    Tspp.debug("iptetpr2", ke, ke.modifiers, Qt.Key_Control, Qt.Key_);
                    if (ke.modifiers == Qt.ControlModifier) {
                        // Ctrl+Enter=Send
                        
                    }else if (ke.modifiers == Qt.MetaModifier) {
                        sendmsg();
                    }

                }
            }
            MyButton{ text:"Emoji"; onClicked: dummy();
                implicitWidth: 32;
                display: AbstractButton.IconOnly
                tiptext: qsTr("Select Emoji(s)")
                icon.source: "../icons/smile_gray64.png"}
            MyButton{ text:"Sendit!!!"; onClicked: sendmsg();
                implicitWidth: 52;
                tiptext: qsTr("Send Message!!!")
                display: AbstractButton.IconOnly
                icon.source: "../icons/cursor_gray64.png"}
            // MyImage {source:"../icons/cursor_gray64.png"; height:26; width:26}
            MyComboBox {       
                id: msgsndmode 
                model: ["dftim", "gptcf", "cmd", "misskey", "gptoa", "nostr"]
            }
        }
    }

    ///////// script

    // all functions are qt slots   
    // 子组件比main组件onCompleted更迟一些，要做初始化加载就在子组件中
    Component.onCompleted: {
        Tspp.debug("");
        Tspp.settimeoutfuncs(qmlSetTimeout, qmlClearTimeout);

        // let rv = qcffi.invoke("thisqml");
        // Tspp.debug(rv);
        // listView.model.dummy()
        // listView.model.append({name:"frommainqml", number: "frommainqml 909 545"})

        // Tspp.dummy('wt')
        // Tspp.util.dummy();
        // JTspp.default.dummy(); // TypeError: Cannot call method 'dummy' of undefined
        // let m1 = new Map();
        // Tspp.debug("m1", m1);

        // upstatusbar();
        upstatusmc(msglstmdl.count);
    }
    //////
    // 二分查找add
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
    function  onloadmsg () {
            Tspp.debug('clicked');
            let req = Tspp.tojson({Cmd: "loadmsg", Argv:["1=1 limit 300"]});
            let resp = qcffi.invoke(req);
            Tspp.debug('resplen', resp.length);
            // let jso = JSON.parse(resp);
            // Tspp.debug("rowcnt", jso.Retc, jso.Retv.length);
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
            //     // Tspp.debug('typeof', typeof rv.Sender)
            // }
            Tspp.debug('itemcnt', listView.model.count);
    }
    function fetchmore() {
        let fmcond = Sss.fetchmore_condstr();
            Tspp.debug('...', Sss.fmnext_batch, fmcond);
            let req = Tspp.tojson({Cmd: "loadmsg", Argv:[fmcond]});
            // if (true) return;
            let resp = qcffi.invoke(req);
            // assert(resp == Sss.bkdretpromis, 'error invoke', req);
            // Tspp.debug('resplen', resp.length);
            // let jso = JSON.parse(resp);
            // Tspp.debug("rowcnt", jso.Retc, jso.Retv.length);
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
            //     // Tspp.debug('typeof', typeof rv.Sender)
            // }
            // Tspp.debug('itemcnt', listView.model.count);
    }
    function loadmsgret(retv) {
        // Tspp.debug("...rowcnt", retv.length);
        let oldcnt = listView.model.count;
        let isnew = retv[0]
        for (let i=1; i < retv.length; i++) {
            let rv = retv[i];
            // let item = {name:"", number: ""};
            let item = Sss.newFediRecord();
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
            item.Mtimemsui = Tspp.objtmstrmin(new Date(item.Mtimems))
            for (let j=0;j < 30; j++) {
                // listView.model.insert(0, item);
            }
            // listView.model.append({name:"frommainqml", number: "frommainqml 909 545"})
            // Tspp.debug('typeof', typeof rv.Sender)

            // listView.model.insert(0, item);
            let prepend = !isnew;
            let ok = msgaddnodup(item, prepend);
            Sss.setnextbatch(item.Mtimems);
            // Tspp.debug(i, ok, item.Eventid);
        }
        let addcnt = listView.model.count - oldcnt;
        if (addcnt>0) {
            // scrollvto(true);
             Tspp.runonce(286, scrollvto, true);
            //  upstatusbar();
            upstatusmc(msglstmdl.count);
        }
        // Tspp.debug('itemcnt',  addcnt, listView.model.count);
    }
    function fetchmorert(roomid) {
        invokebkd("loadmorert", roomid);
    }

    function sendmsg() {
        // Tspp.debug("Sss", Sss.foo, Sss.getsndmsgpfx("dftim"), JSON.stringify(Sss.barz));
        // return;

        let sndmode = msgsndmode.currentValue;
        let msgpfx = Sss.getsndmsgpfx(sndmode);
        let msg = usriptmsg.text;
        msg = msgpfx + msg;
        Tspp.debug("usriptmsg", msg.length, sndmode, msg);

        let req = Tspp.tojson({Cmd: "sendmsg", Argv:[sndmode, msg]});
        let resp = qcffi.invoke(req); // todo: will freeze ui
        Tspp.debug("resp", resp);
        if (false) { // async mode, no result data here
            let jso = JSON.parse(resp);
            let item = {Content: jso.Retv[0]};
            listView.model.insert(0, item);
        }
    }
    function sendmsgret(cmdo) {
        let item = Sss.newFediRecord();
        item.Content = cmdo.Retv[0].content;
        item.Dtime = cmdo.Dtime// rv.Dtime == '' ? rv.dtime : rv.Dtime;
        item.name = item.Sender = "gptcfai";
        item.Feditype = "gptcf";
        item.Roomid = "mainline@cf";
        item.Roomname = "mainline";
        item.Eventid = '' //rv.Eventid!=''? rv.Eventid : "$ifsf";
        let nowt = new Date();
        item.Eventid = '$'+nowt.valueOf();
        // item.Mtimems = (new Date()).tohhmm();
        item.Mtimems = nowt.valueOf();
        item.Mtimemsui = Tspp.objtmstrmin(nowt);
        // item = rv;

        // listView.model.insert(0, item);
        msgaddnodup(item, false);
        // scrollvto(false);
        Tspp.runonce(286, scrollvto, false);
    }


    function scrollvto(top : bool) {
        // Tspp.debug("top=", top);
        // 0.0 - 1.0
        let sbv = scroll1.ScrollBar.vertical;
        if (top) {
            sbv.position = 0.0;
        }else{
            // Tspp.debug("nowpos", sbv.position);
            sbv.position = 1.0 - sbv.size // scroll1.contentHeight - scroll1.height;
            // Tspp.debug("cch", scroll1.contentHeight, "winh", scroll1.height);
        }
    }

    property int txtccfmt: Text.MarkdownText
    function setccfmt(f) { txtccfmt  = f }

    // async function dummy() {} // not work syntax error
}
