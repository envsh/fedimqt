

import QtQml
import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Material
import QtQuick.Layouts


// Rectangle {}
// Text 
// Button
// QtObject { }

// ApplicationWindow {
// Window {
Rectangle {
    // width: parent == null ? 300 : parent.width
    // height: parent == null ? 300 : parent.height
    width: 300
    height: 300

    Material.theme : Material.dark
    color: Material.background

    Text {
        text: "hehhe"
        color: Material.foreground
    }

}
