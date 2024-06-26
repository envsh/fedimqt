

import QtQml
import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Material
import QtQuick.Layouts

import "../qmlpp"

import ListModelBase

// Rectangle {}
// Text 
// Button
// QtObject { }

// Rectangle {
//     color: Material.background
Item {
    ////////////
    id: topwin
    // width: 500
    // height: 500
    // anchors.fill: parent
    width: parent.width
    height: parent.height
    visible: true

    // Rectangle {
    MyText {
        id: ptitle
        height: 30
        width: parent.width
        text: "logui page ..."
    }
    // }

ScrollView {
        width : parent.width
        anchors.leftMargin: 5
        anchors.top : ptitle.bottom
        height: parent.height-30
        id: scroll2

    ListView {
        id: listView
        anchors.fill: parent
        width : parent.width
        anchors.leftMargin: 5

        // model: ListModel{
        //     ListElement {
        // name: "Bill Smith"
        // number: "555 3264loggg"
        // Content: ""
        // Roomid: ""
        // Roomname: ""
        // Feditype: ""
        // Eventid: ""
        // Sender: ""
        // Mtimems: 0
        //     }
        // }
        model: ListModelBase {
            id: loglstmdl
            objectName: "loglstmdl"
        }

        delegate: Item {
            // color: Material.background
            // color: "red"
            width: topwin.width
            // height: topwin.height
            height: 32
            MyLabel {
                text: Index + " : " + Content
                width: topwin.width
                tiptext: Index + " : " + Ctimemsui + " "  + Content
            }
        }

    }

    }

    // script
    Component.onCompleted:{}
    // function addlog(logstr) {
    //     let item = {};
    //     item.number = item.Content = logstr;
    //     listView.model.append(item);

    //     scroll1.ScrollBar.vertical.position = 1.0 - scroll1.ScrollBar.vertical.size;
    // }

}
