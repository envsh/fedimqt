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

// import js now, from tspp/main.js
import "main.js" as Lib;


ApplicationWindow {
    ///
    QmlCppBridge {    id : qcffi }

    // all functions are qt slots   
    function oncallqml(str) {
        Lib.debug(str);
        Lib.info("lstcnt", listView.count);  // print ui object property
    }

    Component.onCompleted: {
        let rv = qcffi.invoke("thisqml");
        Lib.debug(rv);
        listView.model.dummy()
        listView.model.append({name:"frommainqml", number: "frommainqml 909 545"})

        Lib.dummy('wt')
        Lib.util.dummy();
        // Jlib.default.dummy(); // TypeError: Cannot call method 'dummy' of undefined
    }

    ////////////
    id: window
    width: 400
    height: 500
    visible: true

    ScrollView {
        anchors.fill: parent
        width : parent.width

    ListView {
        id: listView
        anchors.fill: parent
        width : parent.width

        model: HelloModel{}


        delegate: GridLayout {
            id: grid
            columns: 1
            // anchors.fill: parent
            // width: 350
            // width: parent.width
            width: listView.width

            // Button {
            //     onClicked: {
            //         Lib.debug('www', ta123.width, ta123.contentWidth)
            //     }
            // }
            // Text { text: name; font.bold: true; }
            // Text { text: number; color: "red" }
            // // Text { text: "in"; font.underline: true }
            Row {
                Layout.fillWidth: true
                width: parent.width
                
            Text { text: "row1"; font.strikeout: true }
            Rectangle {
                // width:350
                width: parent.width
                height: txtcc.contentHeight
            Text {
                id : txtcc
                width: parent.width
                // width: 350
                text: Content
                // text: "If this property is set to true, the layout will force all cells to have an uniform Height. The layout aims to respect";
                 wrapMode: Text.WrapAnywhere; 
                 }
            }
            }
            Row {
            Text { text: "row1"; font.strikeout: true }
            Text { text: "row2"; font.strikeout: true }
            Text { text: "row3"; font.strikeout: true }
            }
            // Text { text: "row"; font.strikeout: true }
            // Text { text: "row"; font.strikeout: true }

            // Text { width: 66; text: Eventid; font.strikeout: true }
            // Text { text: "row"; font.strikeout: true }
            // Text { text: "row"; font.strikeout: true }
        }

        // delegate: TextArea {
        //     readOnly : true
        //     text: name + ": " + number
        // }
        // delegate: Text {
        //     text: name + ": " + number
        // }

    }
    }

    Button {
        anchors.centerIn: parent
        text: "Hello world!!!你好，世界！！！"
        onClicked: {
            Lib.debug('clicked');
            let req = Lib.tojson({Cmd: "loadmsg", Argv:["1=1 limit 300"]});
            let resp = qcffi.invoke(req);
            Lib.debug('resplen', resp.length);
            let jso = JSON.parse(resp);
            Lib.debug("rowcnt", jso.Retc, jso.Retv.length);
            for (let i=0; i < jso.Retc; i++) {
                let rv = jso.Retv[i];
                // let item = {name:"", number: ""};
                let item = rv;
                item.name = rv.Sender;
                item.number = rv.Roomid;
                listView.model.insert(0, item);
                for (let j=0;j < 30; j++) {
                    listView.model.insert(0, item);
                }
                // listView.model.append({name:"frommainqml", number: "frommainqml 909 545"})
                // Lib.debug('typeof', typeof rv.Sender)
            }
            Lib.debug('itemcnt', listView.model.count);
        }
    }

    ComboBox {
        anchors.centerIn: parent

        // As currentValue was added in 2.14, the versioned import above
        // should cause this property to be used, but instead an error is produced:
        // "Cannot override FINAL property"
        // property int currentValue: 0
    }


}