

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
Item {
    width: 300
    height: 300

    // color: Material.background

    GridLayout {
        columns: 2

        MyText {text:"about"}
        MyText {text: "aboutui of im.fedy.chatnt"}
        MyText {}
        MyText {text: "aboutui of im.fedy.chatnt"}
        MyText {}
        MyText {text: "aboutui of im.fedy.chatnt"}

        MyLabel {text: "platform"}
        MyLabel {text: JSON.stringify(Qt.platform)}

        MyLabel {text: "CompQtVer"}
        MyLabel {text: ""}
        MyLabel {text: "RunQtVer"}
        MyLabel {id:rtqtver; text: ""}
        MyLabel {text: "RunGoVer"}
        MyLabel {id:rtgover; text: ""}

        MyLabel {text: "AppVer"}
        MyLabel {text: Application.version}

        MyLabel {text: "AppArg"}
        MyLabel {text: Application.arguments}

        MyLabel {text: "Workdir"}
        MyLabel {id:workdir; text: ""}
    }

    /////
    function setrtqtver(val) {
        rtqtver.text = val;
    }
    function setworkdir(val) {
        workdir.text = val;
    }
    function setrtgover(val) {
        rtgover.text = val;
    }
}