

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

// Rectangle {
    // color: Material.background
Item {
    ////////////
    id: topwin
    // width: 500
    // height: 500
    width: parent.width
    height: parent.height
    visible: true


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

    // //
    // //  Slot called when the flick has started
    // //
    // onFlickStarted: {
    //     // refreshFlik = atYBeginning
    //     console.log("refreshing111...???")
    // }

    // //
    // //  Slot called when the flick has finished
    // //
    // onFlickEnded: {
    //     // if ( atYBeginning && refreshFlik )
    //     {
    //         // refresh()
    //         console.log("refreshing...???")
    //     }
    // }


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
        // Tspp.debug("hehhe",grplstmdl.count);
        // upstatusrc(grplstmdl.count);
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
