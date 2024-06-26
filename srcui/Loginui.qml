

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

// Rectangle {
//     color: Material.background
Item {
    // width: 400
    width: parent.width
    height: parent.height
    // height: 400
    // anchors.fill: parent // StackView has detected conflicting anchors???

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


        Item { height: 50}
    MyLabel {text: qsTr("Logined Accounts:"); height: 50}
        
    MyLabel {text: qsTr("Accounts:"); height: 50}
    ComboBox {
                id: acclst
                objectName: "acclst" 
                model: []
                // model: ListModel{}
                // width: parent.width
                height: 30
                Layout.fillWidth: true
    }

        Item { height: 50}
        MyLabel {text:"New Account"}

        MyLabel {text:"Username"}
        TextArea { text:  "";
            // color: Material.foreground
            Layout.fillWidth: true
            placeholderText: qsTr("Username")
            }

        MyLabel {text: qsTr("Password")}
        TextArea { text:  ""; 
            // color: Material.foreground
            Layout.fillWidth: true
            placeholderText: qsTr("Password")
            }

        MyLabel {text: qsTr("Access Token")}
        TextArea { text:  ""; 
            // color: Material.foreground
            Layout.fillWidth: true
            placeholderText: qsTr("Access Token")
            }

        MyLabel {text:"Server"}
        ComboBox {
            Layout.fillWidth: true
            editable : true
            model: ["matrix.org", "bolha.chat", "nope.chat", "chat.mozilla.org",
                "trpger.us", "misskey.gg",]
        }

        MyLabel {text:"FediType"}
        ComboBox {
            Layout.fillWidth: true
            editable : false
            model: ["Matrix", "Misskey", "Mastodon", "Nostr", "Telegram"]
        }


    }
    RowLayout {
        Layout.fillWidth: true
        spacing: 50
        Layout.leftMargin: 30
        Layout.rightMargin: 30

        MyButton {
            Layout.fillWidth: true
            text: "&Cancel"
        }
        MyButton {
            Layout.fillWidth: true
            text: "&Login"
            onClicked: {
                // invokebkd('loginaccountline', acclst.currentValue);
                calljs("loginaccountline");
            }
        }
    }

    Item { implicitHeight: 4000; }
    }

    ///// script
    function addloginline(line) {
        acclst.model.push(line);
    }
}