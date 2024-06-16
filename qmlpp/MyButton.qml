


import QtQml
import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Material
import QtQuick.Layouts


// Rectangle {}
// Text 
// Button
// QtObject { }

// compact mode
Button{
    text:"CTBTN:)" 
    // flat: true
    spacing: 1
    leftPadding: 1
    rightPadding: 1
    topPadding: 1
    bottomPadding: 1

    implicitHeight: 45
    // implicitWidth: 90

    property string tiptext//: qsTr("Save the active project")
    ToolTip{ 
        visible: hovered && tiptext.length>0
        // visible: down
        text: tiptext
    }

    HoverHandler {
        enabled: true
        cursorShape: Qt.PointingHandCursor
    }

}