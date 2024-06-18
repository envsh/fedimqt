

import QtQml
import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Material
import QtQuick.Layouts


// Rectangle {}
// Text 
// Button
// QtObject { }

// label with tooltip
Label{
    text: "MyLabel"
                
    elide: Text.ElideRight
    maximumLineCount: 1

    property string tiptext//: qsTr("Save the active project")
    ToolTip{ 
        visible: hh.hovered && tiptext.length>0
        // visible: down
        text: tiptext
    }

    HoverHandler {
        id: hh
        enabled: true
        // cursorShape: Qt.PointingHandCursor
    }
}

