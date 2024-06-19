

import QtQml
import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Material
import QtQuick.Layouts

import "../qmlpp"

import Aboutuint

// Rectangle {}
// Text 
// Button
// QtObject { }

// Rectangle {
Item {
    // 为什么在main.qml里可以初始化，在这就不行呢？
    // 在这需要import一下？？？
    Aboutuint{ id: uiofnt; objectName: "Aboutuint" }
    property int passwd : 6789 // get property in c++ // works
    objectName: "Aboutuiqml" // findChild in c++ // works
    // id: aboutuiqml

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
        MyLabel {id:compqtver; text: uiofnt.qtctver}
        MyLabel {text: "RunQtVer"}
        MyLabel {id:rtqtver; text: uiofnt.qtrtver}
        MyLabel {text: "RunGoVer"}
        MyLabel {id:rtgover; text: ""}

        MyLabel {text: "AppVer"}
        MyLabel {text: Application.version}

        MyLabel {text: "AppArg"}
        MyLabel {text: Application.arguments}

        MyLabel {text: "Workdir"}
        MyLabel {id:workdir; text: ""}

        MyLabel {text: "TestProp1"}
        MyLabel {id: testprop1; text: ""}
    }

    /////
    function setcompqtver(val) {
        // compqtver.text = val;
    }
    function setrtqtver(val) {
        // rtqtver.text = val;
    }
    function setworkdir(val) {
        workdir.text = val;
    }
    function setrtgover(val) {
        rtgover.text = val;
    }
}