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
import ListModelBase // C++/Go implmention

import "../qmlpp"

// https://github.com/mohammadhasanzadeh/pulltorefreshhandler
// import pulltorefresh 2.0
// import "../qmlpp/com/melije/pulltorefresh"

// how singleton main.js???
// import js now, from tspp/main.js
// import "../main.js" as Lib;

// ApplicationWindow {
Item {
    id: topwin
    // width: 500
    // height: 580
    width: parent.width
    height: parent.height
    // color: Material.background

ScrollView {
    ////////////
    visible: true
    width: parent.width
    height: parent.height-msgsndbar.height
    id: scroll1
    objectName: "scroll1"

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
        // width : parent.width
        anchors.leftMargin: 5
        currentIndex: -1
        cacheBuffer: 0 // 好像没啥用
        // smooth: true
        // 好像不怎么管用???
        maximumFlickVelocity: 3800 // for android, default 400???
        // verticalVelocity: 800 // readonly
        // clip: true // fix painting outside of parent scroll

        // context menu
        // 如果放在 delegate中，这种用法会生成很多 Menu 实例？？？
        Menu {
            id: contextMenu
            MenuItem { text: "&Copy" ; onTriggered: calljs("msglstctxcpy", listView.currentIndex) }
            MenuItem { text: "&Edit" ; onTriggered: calljs("msglstctxedt", listView.currentIndex) }
            MenuItem { text: "&View Source"; onTriggered: calljs("msglstctxvwsrc", listView.currentIndex) }
            MenuItem { text: "&Cut" }
            MenuItem { text: "&Paste" }
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

    // 这个必须用Rectangle,不然没法在选中时设置高亮背景
    // 内部子组件不使用 Rectangle,似乎滚动时的CPU减小了,40-50% 降低到 30-40%
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

            // Component.onDestruction : {
            //     console.count("msgdgtitem dtor");
            // }

            // todo 这个会覆盖Text的 linkActived 信号？？？
            // MouseArea 和 TapHandler 也是冲突的
                // MouseArea {
                //     anchors.fill: parent
                //     acceptedButtons: Qt.LeftButton | Qt.RightButton
                //     onClicked: (evt) => {
                //         // console.log("ma", evt);
                //         let oldidx = listView.currentIndex;
                //         if (evt.button === Qt.RightButton) {
                //             contextMenu.popup();
                //         }else{
                //         listView.currentIndex = oldidx==index?-1:index;
                //         // Tspp.debug('lstcuridx', oldidx, "=>", index);
                //         }
                //     }
                // }

        // 无法排除双击的第一击
        TapHandler {
            acceptedButtons: Qt.LeftButton // Qt.AllButtons
            acceptedDevices: PointerDevice.AllDevices
            onLongPressed: {
                // need map to global
                // android not work???
                let globpt = point.scenePosition;
                    contextMenu.x = globpt.x;
                    contextMenu.y = globpt.y;
                    if (Qt.platform.os == "android") {
                        contextMenu.popup();
                    }
                    // contextMenu.open();
                    // console.log(point.scenePosition);
                    // 可是在android上一直在屏幕中间？？？
                    if (Qt.platform.os=="android") {
                    }else{ // this works good
                    }
                // console.log("TapHandler.onLongPressed", point);
            }
            onSingleTapped: (evtpt) => {
                // console.log("onSingleTapped", evtpt, target);
                // console.log("onSingleTapped", evtpt.button, target);
                let oldidx = listView.currentIndex;
                listView.currentIndex = oldidx==index?-1:index;
            }
            onDoubleTapped: (evtpt) => {
                console.log("LB.onDoubleTapped", evtpt);
                // show big content
            }
        }
        TapHandler { // desktop
            acceptedButtons: Qt.RightButton // Qt.AllButtons
            onSingleTapped: (evtpt) => {
                // console.log("RB.onSingleTapped", evtpt.button, target);
                if (Qt.platform.os != "android") {
                    contextMenu.popup();
                }
            }
        }

            // Rectangle {
                Layout.fillWidth: true
                // color: "gray"
                height: 30 + txtcc2.height + 30 + 10 // +10 at item bottom
                // height: 30 + 30 + 30 + 10
                // height: 90

                MyImage { id: usrico
                    anchors.top: parent.top
                    anchors.left: parent.left
                    anchors.topMargin: 8
                    anchors.rightMargin: 5
                    source:"../icons/icon_avatar.png"; 
                    width:42; height:42; }

            // Label {
            //     id: msgrow1
            //     // anchors.top : txtcc2.bottom
            //     anchors.left: usrico.right
            //     width: parent.width
            //     text: Msgtopline
            //     color: Material.foreground
            // }

                RowLayout{
                    id: msgrow1
                    height: 20
                    // anchors.fill: parent
                    anchors.right : parent.right
                    anchors.left : usrico.right
                    anchors.leftMargin: 5
                // Button {
                //     id: inbtn
                //     text:"tbn1"
                //     flat: true
                //     // anchors.right: parent.right
                // }

                Item {
                    width: 120
                    opacity: 0.8
                    // anchors.left: usrico.right
                    
                MyText {
                    width: parent.width
                    id: inbtn
                    text: Sender
                    // tiptext: 'sender:'+Sender
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
                Item {
                    width: 120
                    opacity: 0.65

                MyText {
                    id: lbroomname
                    text: Roomname==''?'Roomname':Roomname
                    // tiptext: 'roomname:'+Roomname
                    width: 120
                    
                }} 
                Item {
                    Layout.fillWidth: true
                    opacity: 0.65
                MyText {
                    id: lbroomid
                    // opacity: 0.65
                    text: Roomid==''?'Roomid':Roomid
                    // tiptext: 'roomid:'+Roomid
                    // width: 120
                    width: parent.width
                    // Layout.fillWidth: false
                }
                }
                // }

                // Button {
                //     id: inbtn2
                //     text:"tbn2"
                //     height: 15
                //     flat: true
                // }
                Item {
                    width: 60
                    opacity: 0.5

                MyLabel {
                    id: inbtn3
                    text: Mtimemsui==''?'Mtimems':Mtimemsui
                    // tiptext: Mtimemsuitip
                    // flat: true
                    width: parent.width
                    horizontalAlignment: Text.Right
                }
                }
                }

                // Content area
                    // Rectangle {
                    Item {
                        // Layout.fillWidth: true
                        anchors.top : msgrow1.bottom
                        // anchors.left : usrico.right
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.topMargin : 12

                        // width:350
                        width: parent.width-16
                        height: txtcc.contentHeight
                        // color: "#505050"
                        // color: window.color
                        // color: Material.background
                        // color: grid.bgcolor
                        // border.width: 3
                        // border.color: "#999"
                        id: txtcc2
                        
                    // todo 首行缩进
                    MsgText {
                        // todo if text too long, folder it???
                        id: txtcc
                        opacity: 0.95
                        // leftPadding: 50
                        textFormat: txtccfmt
                        text: '　　　' + (Content!=''?Content:'Content here')
                    }
                    MyImage{source:"../icons/MessageListSending@2x.png"; width:15
                        anchors.right: txtcc.right;
                        anchors.bottom: txtcc.bottom;}
                    }

                // msg footer area
            // Label {
            //     anchors.top : txtcc2.bottom
            //     width: parent.width
            //     text: Msgbtmline
            //     color: Material.foreground
            // }
                RowLayout {
                    anchors.top : txtcc2.bottom
                    anchors.horizontalCenter : parent.horizontalCenter
                    width: parent.width-16
                    height: 20
                    Item {
                        width:120
                        opacity: 0.5
                    // height: 30
                    // color: "red"

                    MyText {
                        text: "fedisite link"
                        // tiptext: "full fedisite link"
                    }  }
                Item {
                    width:90
                    opacity: 0.5
                    Layout.fillWidth: true
                    // height: 30
                    // color: "red"
                MyText {
                    id: labevtid
                    text: Eventid==''?"Eventid here":Eventid;
                    // tiptext: Eventid
                    // width: 120 
                    // color: "red"
                    anchors.right : parent.right
                    anchors.left : parent.left
                }}
                // Dtime
                Item {
                    width:120
                    opacity: 0.5
                    // height: 30
                    // color: "red"
                MyText {
                    id: labdtime
                    text: Dtime==''?"Dtime":Dtime
                    // tiptext: 'dtime:'+Dtime
                    width: 120
                    horizontalAlignment: Text.Right
                }}     
            }
            
        }
    
    // try pull up/down load more/refresh
    property int mincty : 0;
    property int maxcty : 0;
    property int pullvalold : 100;
    property var pullbtime : null; // Date

        onContentYChanged: {
            // flickableDirection  2 virtical, 
            // console.debug(contentY, height, contentHeight, flickableDirection,atYBeginning)
            if (flickableDirection == 2) {
                if (atYBeginning) {
                    if (contentY < mincty) {
                        mincty = contentY;
                    }
                }else{
                    if (contentY > maxcty) {
                        maxcty = contentY;
                    }
                }
            }
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
                // console.info("fetch more older triggered", listView.verticalOvershoot);
            } else if (listView.verticalOvershoot > 16.0) {
                // console.info("refresh latest triggered", listView.verticalOvershoot);
            }

        }
        onMovementEnded: {
            let nowt = new Date();
            let sbv = scroll1.ScrollBar.vertical;
            // console.debug("drag end", sbv.position, sbv.size);
            // console.debug("move end", pullbtime, nowt);
            if (pullbtime == null) return;
            let dtms = nowt.valueOf() - pullbtime.valueOf();
            // console.debug("move end", dtms, mincty, maxcty, contentY);

            if (mincty <= -5 || maxcty >= 5) {
                pulldownres(1);
            }

            mincty = maxcty = 0;
            pullbtime = null;
        }
        onMovementStarted: {
            let nowt  = new Date();
            let sbv = scroll1.ScrollBar.vertical;
            // Tspp.debug("drag end", sbv.position, sbv.size);
            // console.debug("move start", pullbtime, nowt);
            pullbtime = nowt;
        }

    // 怎么检测 cancel
    // which 1: mine, 2
    function pulldownres(which) {
        let nowt = new Date();
        let osv = Qt.platform.os;
        let dtms = nowt.valueOf() - pullbtime.valueOf();
        // console.log("pull down reslove", osv, which, nowt, prhh.threshold)
        if (which == 2) {
            // console.log("quick pull active", dtms, which);
            if (osv == "android") {
                // pulldownfinal();
            }else {
            }
        }else if (which == 1) {
            let tsok = dtms > 586;
            if (tsok) {
                // console.log("should be active", dtms, which);
                if (osv == "osx" ) {
                    if (atYBeginning ) {
                    // pulldownfinal();
                    }
                }else{
                }
            }
        }
    }

    function pulldownfinal() {
        let nowt  = new Date();
        let dtms = nowt.valueOf() - pullbtime.valueOf();
        console.log("pull down final...", mincty, dtms);
        calljs("fetchmorert", "");
    }
    // 没有数据的时候接收不到
    function pullupfinal() {
        let nowt  = new Date();
        let dtms = nowt.valueOf() - pullbtime.valueOf();
        console.log("pull up final...", maxcty, dtms);
        calljs("fetchmorert", "");
    }

        // interactive : true
        // onFlickStarted: {
        //     // refreshFlik = atYBeginning
        //     console.log("refreshing111...???")
        // }
        // onFlickEnded: {
        //     // if ( atYBeginning && refreshFlik )
        //     {
        //         // refresh()
        //         console.log("refreshing...???")
        //     }
        // }

        // 似乎比自己检测的准确,上面的检测发出几条触发事件,这个只触发一条
        // todo 在DESKTOP端触发比较难达到,需要额外的处理
        // onPullDownRelease 大概在 -100 触发
        // onPullDownRelease 大概在 +100 触发
        PullToRefreshHandler
        {
            id: prhh
            // default 20
            // android设置到50,100就很难触发???
            // 这个属性不会是比例吧???
            // 在 macos 上拉不动,需要设置小一点
            threshold: Qt.platform.os == "android"? 30 : 5
            onPullDown : {
                // console.log("pull down hh", nowt);
            }
            onPullUp : {
                // console.log("pull up hh", nowt);
            }
            onPullDownRelease:
            {
                let ovst = listView.verticalOvershoot;
                // Add your handling code here:
                // console.log("ohmy onPullDownRelease", listView.mincty);
                listView.pulldownfinal();
            }

            onPullUpRelease:
            {
                let ovst = listView.verticalOvershoot;
                // Add your handling code here:
                // console.log("ohmy onPullUpRelease", listView.maxcty);
                listView.pullupfinal();
            }
        }
    }


}
    // msgsendbar
    Rectangle {
        color: Material.background
        // color: "blue"
    // Item {
        id: msgsndbar
        width: parent.width
        height: 60

        anchors.top : scroll1.bottom

        RowLayout {
            anchors.left : parent.left
            anchors.right : parent.right

            MyButton{ text:"SIMG"; implicitWidth: 32;
                // tiptext: qsTr("Select and send Photo/File(s)")
                display: AbstractButton.IconOnly
                icon.source: "../icons/add.png"}

            TextArea {
                // TODO 不要在编辑的时候在上边显示提示
                placeholderText: (!focus && text=='') ? qsTr("Enter message") : ''
                // preeditText: qsTr("Enter message")
                id: usriptmsg
                objectName: "usriptmsg"
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
                        // sendmsg();
                        calljs("msglst.sendmsg");
                    }

                }
            }
            MyButton{ text:"Emoji"; onClicked: dummy();
                implicitWidth: 32;
                display: AbstractButton.IconOnly
                // tiptext: qsTr("Select Emoji(s)")
                icon.source: "../icons/smile_gray64.png"}
            MyButton{ text:"Sendit!!!"; 
                // onClicked: sendmsg();
                onClicked: calljs("msglst.sendmsg");
                implicitWidth: 52;
                // tiptext: qsTr("Send Message!!!")
                display: AbstractButton.IconOnly
                icon.source: "../icons/cursor_gray64.png"}
            // MyImage {source:"../icons/cursor_gray64.png"; height:26; width:26}
            MyComboBox {       
                id: msgsndmode 
                objectName: "msgsndmode"
                model: ["dftim", "gptcf", "cmd", "misskey", "gptoa", "nostr"]
            }
        }
    }

    ///////// script

    // all functions are qt slots   
    // 子组件比main组件onCompleted更迟一些，要做初始化加载就在子组件中
    Component.onCompleted: {
        console.log("Component.onCompleted.MsgListView.qml");
        // Tspp.debug("");
        // Tspp.settimeoutfuncs(qmlSetTimeout, qmlClearTimeout);

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
        // upstatusmc(msglstmdl.count);
    }
    //////

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

    function fetchmorert(roomid) {
        invokebkd("loadmorert", roomid);
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
    // function setccfmt(f) { txtccfmt  = f }

    // async function dummy() {} // not work syntax error
}
