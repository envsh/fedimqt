

import QtQml
import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Material
import QtQuick.Layouts

// 单行，限长截断的Text
Text {
    text: "mytextcp"
                    color: Material.foreground
                    elide: Text.ElideRight
                    maximumLineCount: 1
                    // width: 30
                    // implicitWidth: 30
                    wrapMode: Text.WrapAnywhere
}
