// Copyright (C) 2018 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause

import QtQml
import QtQml.WorkerScript
import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Material
import QtQuick.Layouts
import QtQuick.Window

/////
import QmlCppBridge 1.0 //

// import js now
import "main.js" as Jlib;


ApplicationWindow {
    ///
    QmlCppBridge {    id : qcffi }

    // all functions are qt slots   
    function oncallqml(str) {
        console.log("oncallqml", str);
        console.log("oncallqml", listView.count); // print ui object property
    }

    Component.onCompleted: {
        qcffi.invoke("thisqml")
        listView.model.dummy()
        listView.model.append({name:"frommainqml", number: "frommainqml 909 545"})

        Jlib.dummy('wt')
        Jlib.util.dummy();
        // Jlib.default.dummy(); // TypeError: Cannot call method 'dummy' of undefined
    }

    ////////////
    id: window
    width: 400
    height: 500
    visible: true

    ListView {
        id: listView
        anchors.fill: parent

        model: HelloModel{}
        
        delegate: Text {
            text: name + ": " + number
        }

    }

    Button {
        anchors.centerIn: parent
        text: "Hello world!!!你好，世界！！！"
    }

    ComboBox {
        anchors.centerIn: parent

        // As currentValue was added in 2.14, the versioned import above
        // should cause this property to be used, but instead an error is produced:
        // "Cannot override FINAL property"
        // property int currentValue: 0
    }


}