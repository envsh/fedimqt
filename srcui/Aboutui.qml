

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
    // color: Material.background
Item {
    // objectName: "Aboutuiqml" // findChild in c++ // works
    // id: aboutuiqml

    // width: 300
    // height: 300
    anchors.fill: parent

    GridLayout {
        anchors.fill : parent
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
        MyLabel {id:compqtver; objectName: "compqtver"; text: "1.0.0"}
        MyLabel {text: "RunQtVer"}
        // MyLabel {id:rtqtver; objectName:"rtqtver"; text: uiofnt.qtrtver}
        MyLabel {id:rtqtver; objectName:"rtqtver"; text: "1.0.0"}
        MyLabel {text: "RunGoVer"}
        MyLabel {id:rtgover; objectName:"rtgover"; text: "1.0.0"}

        MyLabel {text: "AppVer"}
        MyLabel {text: Application.version}

        MyLabel {text: "AppArg"}
        MyLabel {text: Application.arguments}

        MyLabel {text: "AppExe"}
        MyLabel {objectName: "appexe"; text: ""}

        MyLabel {text: "Workdir"}
        MyLabel {id:workdir; objectName:"workdir"; text: "./"}

        MyLabel {text: "Archinfo"}
        MyLabel {id: archinfo; objectName: "archinfo"; text: ""}

        MyLabel {text: "Uname"}
        MyLabel {id: unameinfo; objectName:"unameinfo";  text: ""}

        MyLabel {text: "TestProp1"}
        MyLabel {id: testprop1; objectName: "testprop1"; text: ""}

    }

    /////
    // function setcompqtver(val) {
    //     compqtver.text = val;
    // }
    // function setrtqtver(val) {
    //     rtqtver.text = val;
    // }
    // function setworkdir(val) {
    //     workdir.text = val;
    // }
    // function setrtgover(val) {
    //     rtgover.text = val;
    // }
}