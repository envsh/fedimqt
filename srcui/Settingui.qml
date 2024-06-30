

import QtQml
import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Material
import QtQuick.Layouts

import "../qmlpp"

// Rectangle {}
// Text 
// Button
// QtObject { }

// ApplicationWindow {
// Window {
Item {
    width: parent === null ? 400 : parent.width
    height: parent === null ? 500 : parent.height
    visible: true

    Material.theme: Material.Dark
    // color: Material.foreground
    // color: "black"

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 9

    GridLayout {
        columns: 2
        Layout.fillWidth: true
        // anchors.top : acclst.bottom
        // anchors.left: parent.left
        // anchors.right: parent.right
        // width: parent.width


        Item { height: 30}
    MyLabel {text: qsTr("App Setting:"); height: 50}

        MyLabel {text:"Menu Font Size"}
        SpinBox {
            value: 11
            from: 2
            to: 32

            // objectName: "loginUsername"
            // color: Material.foreground
            Layout.fillWidth: true
            // placeholderText: qsTr("Username")
            }

        MyLabel {text:"Msg Font Size"}
        SpinBox {
            value: 11
            from: 2
            to: 32

            // objectName: "loginUsername"
            // color: Material.foreground
            Layout.fillWidth: true
            // placeholderText: qsTr("Username")
            }

    MyLabel {text: qsTr("App Theme:"); height: 50}
    ComboBox {
                id: acclst
                objectName: "apptheme" 
                model: ["Dark", "Light"]
                // model: ListModel{}
                // width: parent.width
                height: 30
                Layout.fillWidth: true
    }

        MyLabel {text: qsTr("Simple Mode")}
        CheckBox {
            Layout.fillWidth: true
        }

        Item { height: 40}
        MyLabel {text:"New Account"}

        MyLabel {text:"Username"}
        TextArea { text:  "";
            // objectName: "loginUsername"
            // color: Material.foreground
            Layout.fillWidth: true
            placeholderText: qsTr("Username")
            }

        MyLabel {text:"Server"}
        ComboBox {
            // objectName: "loginServer"
            Layout.fillWidth: true
            editable : true
            model: ["matrix.org", "bolha.chat", "nope.chat", "chat.mozilla.org",
                "misskey.gg",]
        }

        MyLabel {text:"FediType"}
        ComboBox {
            // objectName: "loginFediType"
            Layout.fillWidth: true
            editable : false
            model: ["Matrix", "Misskey", "Mastodon", "Nostr", "Telegram"]
        }


    }
    RowLayout {
        Layout.fillWidth: true
        spacing: 40
        Layout.leftMargin: 30
        Layout.rightMargin: 30

        MyButton {
            Layout.fillWidth: true
            text: "&Cancel"
        }
        MyButton {
            Layout.fillWidth: true
            text: "&Save"
            onClicked: {
                // invokebkd('loginaccountline', acclst.currentValue);
                calljs("savesetting");
            }
        }
    }

    Item { implicitHeight: 4000; }
    }

    
    // Component.onCompleted: {
    //     console.log(parent, width, height);
    // }
}
