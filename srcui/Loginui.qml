

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
    width: 300
    height: 300

    color: Material.background

    GridLayout {
        columns: 2

        MyText {text:"login account..."}
        MyText {text: "aboutui of im.fedy.chatnt"}
        MyText {}
        MyText {text: "aboutui of im.fedy.chatnt"}
        MyText {}
        MyText {text: "aboutui of im.fedy.chatnt"}

    }
}