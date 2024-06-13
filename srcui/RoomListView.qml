

import QtQml
import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Material
import QtQuick.Layouts


// Rectangle {}
// Text 
// Button
// QtObject { }

Rectangle {

    ////////////
    id: topwin
    width: 500
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
            ListElement {
        name: "Bill Smith"
        number: "555 3264romlst"
        Content: ""
        Roomid: ""
        Roomname: ""
        Feditype: ""
        Eventid: ""
        Sender: ""
        Mtimems: 0
            }
        }

        delegate: Rectangle {
            color: Material.background
            width: topwin.width
            height: topwin.height
            MyText {
                text: name + " : " + number
            }
        }

    }

    }

}
