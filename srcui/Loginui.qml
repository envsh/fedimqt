

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

Rectangle {
    // width: 400
    width: parent.width
    height: 400

    color: Material.background

    ComboBox {
                id: acclst
                objectName: "acclst" 
                model: []
                // model: ListModel{}
                width: parent.width
    }
    GridLayout {
        columns: 2
        anchors.top : acclst.bottom
        anchors.right: parent.right
        width: parent.width-55
        

        MyLabel {text:"login account..."}
        TextEdit { text:  "aboutui of im.fedy.chatnt";
            color: Material.foreground}

        MyText {}
        TextEdit { text:  "aboutui of im.fedy.chatnt"; 
            color: Material.foreground}

        MyText {}
        TextEdit { text:  "aboutui of im.fedy.chatnt"; 
            color: Material.foreground}

        MyButton {
            text: "&Cancel"
        }
        MyButton {
            text: "&Login"
            onClicked: {
                // invokebkd('loginaccountline', acclst.currentValue);
                calljs("loginaccountline");
            }
        }

    }

    ///// script
    function addloginline(line) {
        acclst.model.push(line);
    }
    // function onGotAccounts(acclines) {
    //     for (let i=0;i < acclines.length; i++) {
    //         let item = acclines[i];
    //         // acclst.model.insert(0,item);
    //         acclst.model.push(item);
    //     }
    // }

    // function onLoginAccoutine(line) {
        
    // }
    // function onLogin(srv, usr, acctk) {

    // }

}