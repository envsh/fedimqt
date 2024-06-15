

import QtQml
import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Material
import QtQuick.Layouts

// import js now, from tspp/main.js
import "../main.js" as Lib;

// Rectangle {}
// Text 
// Button
// QtObject { }

Rectangle {

    ////////////
    id: topwin
    // width: 500
    width: parent.width
    height: 500
    visible: true
    color: Material.background

    // Material.theme: Material.Dark

    // Rectangle {
    MyText {
        id: ptitle
        height: 30
        width: parent.width
        text: "room list page..."
    }
    // }

ScrollView {
        width : parent.width
        anchors.leftMargin: 5
        anchors.top : ptitle.bottom
        height: parent.height-30

    ListView {
        id: listView
        anchors.fill: parent

        model: ListModel{
            id: grplstmdl
            ListElement {
        name: "Bill Smith"
        number: "555 3264romlst"
        Content: ""
        Roomid: "Roomid"
        Roomname: "Roomname"
        Feditype: ""
        Eventid: ""
        Sender: ""
        Mtimems: 0
        Mtimemsui: ''
            }
        }

        delegate: Rectangle {
            color: Material.background
            // color: tranparent
            width: topwin.width
            // height: topwin.height
            height: 66
            // color: "red"

            RowLayout{
                anchors.right : parent.right
                anchors.left : parent.left
            MyImage {
                id: grpico
                source: "../icons/group_40.png"
                width:52
                height: 52
            }
            ColumnLayout{
                Layout.fillWidth: true
                RowLayout{
                    // feditype icon
                    MyImage {
                        source: "../icons/favicon.png"
                        width:15
                    }
                    Rectangle {
                        width: 120
                        height: 32
                        color: Material.background
                    MyText {
                        id: grpitem
                        text: Roomname
                        font.pixelSize: sss.dftft.pixelSize+9
                    }
                    }
                    Rectangle {
                        Layout.fillWidth:true
                        color: Material.background
                        height: 32
                    MyText {
                        id: wtttt
                        text: Roomid
                        // width: 120
                        verticalAlignment: Text.Center
                    anchors.right : parent.right
                    anchors.left : parent.left
                    }
                    }
                    // 时间，右对齐，hh:mm
                    Rectangle{
                        // color: "blue"
                        color: Material.background
                        width: 90
                        height: 26
                    MyText {
                        // id: wtttt
                        text: Mtimemsui
                        width: 120
                        font.pixelSize: sss.dftft.pixelSize-1
                        horizontalAlignment: Text.Right
                    }
                    }
                }
                RowLayout{
                    
                    Layout.fillWidth:true
                    Rectangle {
                        // width: listView.width-152
                        // color: "blue"
                        // color: tranparent
                        color: Material.background
                        // width: 120
                        Layout.fillWidth: true
                        height: 26
                    MyText {
                        // id: grpitem
                        text: Content
                        // width: 120
                    anchors.right : parent.right
                    anchors.left : parent.left
                    }
                    }

                    // 未阅读消息数
                    MyImage {
                        source: "../icons/telepathy_kde.png"
                        width:15
                    }

                }

            }
            }
        }

    }

    }

    ///// script
    Component.onCompleted : {
        Lib.debug("hehhe",grplstmdl.count);
        upstatusrc(grplstmdl.count);
    }

    function grpaddnodup(item, prepend) {
        let has = sss.grps.has(item.Roomid);
        if (!has) {
            sss.grps.set(item.Roomid, item);
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
    function loadmsgret(retv) {
        Lib.debug("...rowcnt", retv.length);
        let oldcnt = listView.model.count;
        for (let i=0; i < retv.length; i++) {
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
            item.Mtimemsui = Lib.objtmstrmin(new Date(item.Mtimems))
            for (let j=0;j < 30; j++) {
                // listView.model.insert(0, item);
            }
            // listView.model.append({name:"frommainqml", number: "frommainqml 909 545"})
            // Lib.debug('typeof', typeof rv.Sender)

            // listView.model.insert(0, item);
            let ok = grpaddnodup(item, true);
            // Lib.debug(i, ok, item.Eventid);
        }
        let addcnt = listView.model.count - oldcnt;
        if (addcnt>0) {
            // scrollvto(true);
            //  Lib.runonce(286, scrollvto, true);
            upstatusrc(grplstmdl.count);
        }
        Lib.debug('grpcnt',  addcnt, listView.model.count);
    }
}
