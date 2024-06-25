

import QtQml
import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Material
import QtQuick.Layouts

import "../qmlpp"

import ListModelBase

// import js now, from tspp/main.js
// import "../main.js" as Lib;

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
        currentIndex: -1

        // context menu
        // 如果放在 delegate中，这种用法会生成很多 Menu 实例？？？
        Menu {
            id: contextMenu
            MenuItem { text: "Cut" }
            MenuItem { text: "Copy" }
            MenuItem { text: "Paste" }
        }

        // model: ListModel{
        //     id: grplstmdl
        //     ListElement {
        // name: "Bill Smith"
        // number: "555 3264romlst"
        // Content: ""
        // Roomid: "Roomid"
        // Roomname: "Roomname"
        // Feditype: ""
        // Eventid: ""
        // Sender: ""
        // Mtimems: 0
        // Mtimemsui: ''
        //     }
        // }
        model : ListModelBase {
            id: grplstmdl
            objectName: "grplstmdl"
        }

        delegate: Rectangle {
            id: itemwin
            // color: Material.background
            // color: tranparent
            width: topwin.width
            // height: topwin.height
            height: 66
            // color: "red"
            property string bgcolor: index == listView.currentIndex ? "#4a4a4a" : Material.background
            color: bgcolor

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

            RowLayout{
                anchors.fill: parent
                // anchors.right : parent.right
                // anchors.left : parent.left
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
                        // color: Material.background
                        color: itemwin.bgcolor
                    MyText {
                        id: grpitem
                        text: Roomname
                        font.pixelSize: Sss.dftft.pixelSize+9
                    }
                    }
                    Rectangle {
                        Layout.fillWidth:true
                        // color: Material.background
                        color: itemwin.bgcolor
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
                        // color: Material.background
                        color: itemwin.bgcolor
                        width: 90
                        height: 26
                    MyText {
                        // id: wtttt
                        text: Mtimemsui
                        width: 120
                        font.pixelSize: Sss.dftft.pixelSize-1
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
                        // color: Material.background
                        color: itemwin.bgcolor
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
        Tspp.debug("hehhe",grplstmdl.count);
        upstatusrc(grplstmdl.count);
    }

    function grpaddnodup(item, prepend) {
        let has = Sss.grps.has(item.Roomid);
        if (!has) {
            Sss.grps.set(item.Roomid, item);
            if (prepend) {
                listView.model.insert(0, item);
            }else{
                listView.model.append(item);
            }
            return true;
        }
        // Tspp.debug('item', !has, item.Eventid, Sss.msgs.size, listView.model.count);
        return false;
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
            let ok = grpaddnodup(item, true);
            // Tspp.debug(i, ok, item.Eventid);
        }
        let addcnt = listView.model.count - oldcnt;
        if (addcnt>0) {
            // scrollvto(true);
            //  Tspp.runonce(286, scrollvto, true);
            upstatusrc(grplstmdl.count);
        }
        // Tspp.debug('grpcnt',  addcnt, listView.model.count);
    }

    function onGotRooms(retv) {
        let oldcnt = listView.model.count;
        for (let i=0;i < retv.length; i++) {
            let item = retv[i];
            item.Mtimemsui = Tspp.objtmstrmin(new Date(item.Mtimems));
            let ok = grpaddnodup(item, true);
        }
        let addcnt = listView.model.count-oldcnt;
        if (addcnt>0) {
            upstatusrc(grplstmdl.count);
        }
        Tspp.debug('grpcnt',  addcnt, listView.model.count);
    }
}
