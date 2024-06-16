


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
ComboBox {
    // text:"CTBTN:)" 
    spacing: 1
    leftPadding: 1
    rightPadding: 1
    topPadding: 1
    bottomPadding: 1
    // height: 30
    implicitHeight: 35
    implicitWidth: 90
    // implicitContentWidthPolicy: ComboBox.WidestText
    flat: true
    editable: false

    model: ["First", "Second", "Third"]

    // anchors.centerIn: parent
    // As currentValue was added in 2.14, the versioned import above
    // should cause this property to be used, but instead an error is produced:
    // "Cannot override FINAL property"
    // property int currentValue: 0
}