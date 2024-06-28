

import QtQml
import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Material
import QtQuick.Layouts


Text {
                        color: Material.foreground;
                    
                        // id : txtcc
                        width: parent.width
                        // width: 350
                        textFormat: Text.MarkdownText
                        // textFormat: Text.RichText
                        font.pixelSize: Qt.platform.os=="android"? 16 : 14
                        // font.pixelSize: normalSize+3

                        // text: "If this property is set to true, the layout will force all cells to have an uniform Height. The layout aims to respect";
                        wrapMode: Text.WrapAnywhere; 



    focus: true
    // focusPolicy: Qt.StrongFocus
    property string tiptext//: qsTr("Save the active project")
    property bool hoveronlink: false
    ToolTip{ 
        // Text 没有 Hovered 属性吧
        visible: tiptext.length>0
        // visible: down
        text: tiptext
    }

    ///
    // todo check scrolling not show
    onLinkHovered: (link)=> {
        let newval = link != '';
        if (newval != hoveronlink) {
            hoveronlink = link != '';
        }
        // console.log(link + " link hovered");
        // if (tiptext != link) tiptext = link;
        // Qt.cursorShape = Qt.PointingHandCursor;
    }
    onLinkActivated: (link)=> {
        console.log(link + " link activated");
        if (link == '') return;
        let ok = Qt.openUrlExternally(link);
    }

    HoverHandler {
        enabled: hoveronlink
        cursorShape: Qt.PointingHandCursor
    }

}