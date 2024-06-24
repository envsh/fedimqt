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

import "qmlpp"
import "srcui"

// import js now, from tspp/main.js
// import "main.js" as Lib;

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
            title: qsTr("&Wndo")
            Action { text: qsTr("&Next Page") ; 
                onTriggered: calljs("switchpage", false)
                // onTriggered: switchpage(false)
                icon.source: "icons/barbuttonicon_forward_gray64.png"}
            Action { text: qsTr("&Prev Page") ;
                onTriggered: calljs("switchpage", true)
                // onTriggered: switchpage(true) 
                icon.source: "icons/barbuttonicon_back_gray64.png"}
            Action { text: qsTr("Logui"); onTriggered: switchpageidx(3) }
            Action { text: qsTr("&Aboutui"); onTriggered: switchpageidx(4) }
            Action { text: qsTr("&Room List"); onTriggered: switchpageidx(1) }
            Action { text: qsTr("&Loginui"); onTriggered: switchpageidx(2) }
            Action { text: qsTr("&Message List"); onTriggered: switchpageidx(0) }
        }
        Menu {
            title: qsTr("&Dev")
            Action { text: qsTr("&Load Message") ;
                onTriggered: calljs("loadmsg");
                // onTriggered: onloadmsg()
            }
            Action { text: qsTr("&Load More Older"); onTriggered: msglstwin.fetchmore() }
            Action { text: qsTr("&Load More Older Rt"); onTriggered: msglstwin.fetchmorert("") }
            Action { text: qsTr("&AutoText"); 
                onTriggered: calljs("msglst.setccfmt", Text.AutoText);
                // onTriggered: msglstwin.setccfmt(Text.AutoText) 
                }
            Action { text: qsTr("&MarkdownText");
                onTriggered: calljs("msglst.setccfmt", Text.MarkdownText);
                // onTriggered: msglstwin.setccfmt(Text.MarkdownText);
                }
            Action { text: qsTr("&RichText"); 
                onTriggered: calljs("msglst.setccfmt", Text.RichText);
                // onTriggered: msglstwin.setccfmt(Text.RichText) 
                }
            Action { text: qsTr("&PlainText"); 
                onTriggered: calljs("msglst.setccfmt", Text.PlainText);
                // onTriggered: msglstwin.setccfmt(Text.PlainText) 
                }
        }
        Menu {
            title: qsTr("&Misc")
            Action { text: qsTr("Scroll Bottom"); 
                // onTriggered: msglstwin.scrollvto(false);
                onTriggered: calljs("msglst.scrollvto", false);
                icon.source: "icons/barbuttonicon_down_2x.png"}
            Action { text: qsTr("Scroll Top");
                onTriggered: calljs("msglst.scrollvto", true);
                // onTriggered: msglstwin.scrollvto(true);
                icon.source: "icons/barbuttonicon_up_2x.png" }
            Action { text: qsTr("&Test ListView");
                onTriggered: tstlstwin.visible=!tstlstwin.visible}
            Action { text: qsTr("&Paste"); 
                onTriggered: calljs("menubar.paste.clicked")}
           Action { text: qsTr("&Paste2"); 
                onTriggered: neslot1_1('hhh')}
        }
        Menu {
            title: qsTr("&Help")
            // .svg not work???
            Action { text: qsTr("&About"); onTriggered: switchpageidx(4) 
                // icon.source: "icons/help.svg"
            }
            Action { text: qsTr("&Settings"); onTriggered: switchpageidx(4)
                icon.source: "icons/barbuttonicon_set.png"}
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
        objectName: "stackwin"
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
        MsgListView{id: msglstwin; objectName: "msglstwin"; visible: false}
        // Rectangle { anchors.fill : parent;  color: "red" } // clear

        Component.onCompleted: {
            // Tspp.debug("stkwin done");
            // stackwin.push(aboutui);
            // stackwin.push(msglstwin);
        }
    }

    Rectangle {
        color: "darkblue"
        // height: inbtn.height
        height: 38
        width: parent.width
        anchors.top: stackwin.bottom// + 3
        RowLayout{
            // verticalAlignment: Text.Center
            anchors.left : parent.left
            anchors.right : parent.right

        // MyLabel { tiptext:"hehehhehehe" }
        MyLabel{ id: msgcntst; objectName:"mainui.stb.msgcntlb"; text: 'MC:'+999}
        MyLabel{ id: grpcntst; objectName:"mainui.stb.grpcntlb"; text: 'RC:'+99}
        MyLabel{id: curwinst; text: 'CP:'+'MSGWIN'}
        MyLabel{id: lastlogst; objectName:"mainui.stb.lastloglb" ; text: 'Ready. wwwweeeeeeeeeeee';
            Layout.fillWidth: true}
        MyButton{
            icon.source:"icons/online_2x.png";
            // icon.source:"icons/question-mark-gray64.png";
            // icon.source:"icons/remove-symbol_gray64.png";
            // icon.color: "black"
            id: onlinest
            objectName: "onlinest"
            tiptext: "net unknown"
            implicitWidth: 24;
            implicitHeight:24;
            flat: true
            display: AbstractButton.IconOnly}
        MyButton{
            visible: !netreqbegin
            icon.source: "icons/transfer.png";
            id: netreqst
            objectName: "netreqstnorm"
            // tiptext: "ffff"
            tiptext: 'UP:'+netrequplen+", DL:"+netreqdownlen
            implicitWidth: 22;
            implicitHeight:24;
            flat: true
            display: AbstractButton.IconOnly
            }
        AnimatedImage{
            id: netreqstloading
            objectName: "netreqstloading"
            visible: netreqbegin
            paused : !netreqbegin
            source: "icons/loadingsp.gif";
            // implicitWidth: 22
            // implicitHeight: 24
            sourceSize.width: 22
            sourceSize.height: 24
        }
        MyLabel{id:uptimest; objectName:"mainui.stb.uptimelb"; text: 'UT:'+999; tiptext: 'Uptime:'+999}
        }
    }

    // ListView {
    //     visible: false
    //     id: tstlstwin
    //     width: parent.width
    //     height: 200
    // model: ListModelBase {
    //     clazz: "msglstmdl" // 用来选择 roleNames 列表
    //     objectName: "msglstmdl"
    // }
    // delegate: Rectangle {
    //     width: 200
    //     height: 50
    //     color: Material.background
    //     MyLabel {
    //         text: Content
    //     }
    // }
    // }

    ///////// script
    property bool netreqbegin: false;
    property int netrequplen: 0;
    property int netreqdownlen: 0;

    QmlCppBridge {    id : qcffi }
    // Aboutuint{ id: uiofnt }
    // ShareState { id: Sss}
    // SingletonDemo { id: oneinst } // not work


    function invokebkd(cmd, ...args) {
        let req = {Cmd: cmd, Argv: args};
        return qcffi.invoke(Tspp.tojson(req));
    }
    function calljs(cmd, ...args) {
        let req = {Cmd: cmd, Argv: args};
        return qcffi.calljs(Tspp.tojson(req));
    }
    // all functions are qt slots   
    function oncallqml(jstr) {
        // Tspp.debug(jstr);
        if (jstr.startsWith('QmlAppEngineOK')) {
            onQmlAppEngineCreated(jstr);
        } else if (jstr.startsWith('hello this c++')){
            // just a debug msg and compqtver
            aboutui.setcompqtver(jstr.substring(15));
        }else{
        // Tspp.info("lstcnt", listView.count);  // print ui object property
        // try {
        let jso = JSON.parse(jstr);
        // Tspp.debug('Cmd:', jso.Cmd, jso.Argv);
        dispatchEvent(jso);
        // }catch(err) {
            // console.error(err, ":", jstr);
            // Tspp.error(err, ":", jstr.length, jstr.substring(0, 56));
        // }
        }
    }
    function dispatchEvent(jso) {
        switch (jso.Cmd) {
            case "notice":
                // if (jso.Argv[0] == "olnchkerr") {upstatusll(Sss.onolnchkerr(jso.Argv)) }
                // else if (jso.Argv[0] == "rtqtver") { aboutui.setrtqtver(jso.Argv[1]) }
                // else if (jso.Argv[0] == "workdir") { aboutui.setworkdir(jso.Argv[1]) }
                // else if (jso.Argv[0] == "rtgover") { aboutui.setrtgover(jso.Argv[1]) }
                // else {Tspp.debug("oohwt", jso.Cmd, jso.Argv)}
                break;
            case "switchpageidx":
                switchpageidx(jso.Argv[0]);
                break;
            case "msglst.scrollvto":
                msglstwin.scrollvto(jso.Argv[0]);
                break;
            case "sendmsg":
                msglstwin.sendmsgret(jso);
                break;
            case "loadmsg":
                msglstwin.loadmsgret(jso.Retv);
                romlstwin.loadmsgret(jso.Retv);
                break;
            case "loadmsgrt":
                msglstwin.loadmsgret(jso.Argv);
                romlstwin.loadmsgret(jso.Argv);
                break;
            case "loadmorert":
                Tspp.info("todoooo", jso.Cmd, jso);
                break;
            case "loadroom":
                romlstwin.onGotRooms(jso.Retv);
                break;
            case "loadroomrt":
                romlstwin.onGotRooms(jso.Argv);
                break;
            case "listcfg":
                if (jso.Argv[0] == "accountline") {
                    loginui.onGotAccounts(jso.Retv);
                    switchpageidx(2);
                }
                break;
            case "getcfg":
                if (jso.Argv[1] == 'lastaccountline') {
                    if (jso.Retc == 2) {
                        invokebkd('loginaccountline', jso.Retv[0]);
                    }else {
                        invokebkd('listcfg', 'accountline');
                    }
                }
                break;
            case "loginaccountline":
                // todo check result
                switchpageidx(0);
                break;

            case 'qmlAppEngineCreated':
                // that's ok
                break;
            default:
                Tspp.info('Not catched case:', jso.Cmd, jso);
                break;
        }
    }

    Component.onCompleted: {
        Tspp.debug("");
        Qmlpp.qmlppinit(appwin);
        Tspp.settimeoutfuncs(qmlSetTimeout, qmlClearTimeout);
        // Tspp.debug("oneinst", MySingleton, MySingleton.pt1, MySingleton.dummy);
        // Tspp.debug("oneinstui", MySingletonui, MySingletonui.objs);
        // Tspp.debug("Sss",  Sss);

        // let rv = qcffi.invoke("thisqml");
        // Tspp.debug(rv);
        // listView.model.dummy()
        // listView.model.append({name:"frommainqml", number: "frommainqml 909 545"})

        // Tspp.dummy('wt')
        // Tspp.util.dummy();
        // JTspp.default.dummy(); // TypeError: Cannot call method 'dummy' of undefined
        // dummymix.dummymix();
        // Tspp.debug(Dmymix, Dmymix.exports.dummymix);
        // Tspp.debug(Dmymix.dmymixfn, Dmymix.dummymix);
        // Tspp.debug(Qmlppx.qmlTimer2(appwin));
    }
    function onCompleted2 () {
    }
    // uifullloaded now
    function onQmlAppEngineCreated(msg) {
        // init some here
        Tspp.debug("wtodo", msg, Sss.bkdretpromis);
        // Tspp.debug("uiofnt.qtrtver", uiofnt.qtrtver);
        let rv = invokebkd("qmlAppEngineCreated"); // notify go
        // check account exists, and login default one
        // if no account, switch to login page
        // let rv = invokebkd("listcfg", "accountline");
        let rv2 = invokebkd("getcfg", "", "lastaccountline");
        // let rv3 = invokebkd("loadroom", "1=1 limit 99");
    }
    //////
    // var pageitems = [aboutui,msglstwin];
    function switchpage(prev : bool) {
        let stkwin = stackwin;
        // Tspp.debug("prev", prev, stkwin.depth, stkwin.curidx, stkwin.childs.length);
        // stackwin.index = -1; // non-exist???
        let nxtidx = stkwin.curidx + ( prev ? -1: 1);
        if (nxtidx < 0) nxtidx = stkwin.childs.length-1;
        if (nxtidx >= stkwin.childs.length) nxtidx = 0;
        Tspp.debug("switpage", stkwin.curidx, "=>", nxtidx);
        stkwin.curidx = nxtidx;

        let curitem = stkwin.currentItem;
        stkwin.replace(curitem, stkwin.childs[nxtidx]);
        
        stkwin.find(function(item, index) {
            Tspp.debug('idx', index);
            // return item.isTheOne
            return false;
        }, StackView.DontLoad);
    }
    function switchpageidx(idx : int) {
        // todo 未完成
        // if (true) { calljs("switchpageidx", idx); return; }
        let stkwin = stackwin;
        let curitem = stkwin.currentItem;
        let nxtidx = idx;
        let nxtitem = stkwin.childs[nxtidx];
        stkwin.curidx = nxtidx;
        Tspp.debug(idx, "curitem", curitem, "nxtitem", nxtitem);
        stkwin.replace(curitem, nxtitem);
    }

    function upstatusrc(cnt) {
        grpcntst.text = 'RC:'+cnt;
    }
    function upstatuscp(pagename) {
        curwinst.text = 'CP:'+pagename;
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