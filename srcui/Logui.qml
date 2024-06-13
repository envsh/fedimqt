

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
        text: "logui page ..."
    }
    // }

ScrollView {
        width : parent.width
        anchors.leftMargin: 5
        anchors.top : ptitle.bottom
        height: parent.height-30
        id: scroll1

    ListView {
        id: listView
        anchors.fill: parent
        width : parent.width
        anchors.leftMargin: 5

        model: ListModel{
            ListElement {
        name: "Bill Smith"
        number: "555 3264loggg"
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

    // script
    Component.onCompleted:{}
    function addlog(logstr) {
        let item = {};
        item.number = item.Content = logstr;
        listView.model.append(item);

        scroll1.ScrollBar.vertical.position = 1.0 - scroll1.ScrollBar.vertical.size;
    }

}
