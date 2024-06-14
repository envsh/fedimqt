

import QtQml
import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Material
import QtQuick.Layouts

// 单行，限长截断的Text，当作 label 使用。
Text {
    text: "mytextcp"
                    color: Material.foreground
                    elide: Text.ElideRight
                    maximumLineCount: 1
                    // width: 30
                    // implicitWidth: 30
                    wrapMode: Text.WrapAnywhere
                    // height: 30
    focus: true
    // focusPolicy: Qt.StrongFocus // qt6.7

    property string tiptext//: qsTr("Save the active project")
    ToolTip{ 
        // Text 没有 Hovered 属性吧
        visible: false && tiptext.length>0
        // visible: down
        text: tiptext
    }

    // script
    //  为什么没有反应
    // onLinkActivated: { console.log('ffffff');}
    // onLinkActivated: (link)=> console.log(link + " link activated")
    // onLinkHovered: (link)=> console.log(link + " link hovered")
}
