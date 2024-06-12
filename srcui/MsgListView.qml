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
// import QmlCppBridge 1.0 //

// import "srcui"

// import js now, from tspp/main.js
import "../main.js" as Lib;

// ApplicationWindow {
// Rectangle {
ScrollView {
    ////////////
    id: topwin
    width: 500
    height: 500
    visible: true
    // color: "#010101"

    Material.theme: Material.Dark
    // Material.accent: Material.Purple
    // Material.foreground : "red"

    //////

        // anchors.fill: parent
        // anchors.bottom : window.bottom-90
        // anchors.top: window.top
        // width : parent.width
        // Layout.fillWidth : true
        // id:scoll1
        // height: window.height-90
        // height: window.height-80
        

    ListView {
        id: listView
        anchors.fill: parent
        width : parent.width
        anchors.leftMargin: 5

        model: HelloModel{}

        delegate: Rectangle {
            id: grid
            // anchors.fill: parent
            // width: 350
            // width: parent.width
            width: listView.width
            border.width: 1
            // border.color: "#5a5a5a"
            color: Material.background

        
            // Rectangle {
                Layout.fillWidth: true
                // color: "gray"
                height: 30 + txtcc2.height + 30
                // height: 90

                RowLayout{
                    anchors.right : parent.right
                    anchors.left : parent.left
                    id: msgrow1
                    height: 32
                // Button {
                //     id: inbtn
                //     text:"tbn1"
                //     flat: true
                //     // anchors.right: parent.right
                // }
                Rectangle{
                    width: 120
                    opacity: 0.8
                Text {
                    id: inbtn
                    text: name
                    // text: "hhhh"
                    color: Material.foreground
                    elide: Text.ElideMiddle
                    maximumLineCount: 1
                    width: 120
                    wrapMode: Text.WrapAnywhere
                }}
                // Rectangle {
                //     Layout.fillWidth:true
                //     Layout.horizontalStretchFactor : 30
                //     // Layout.preferredWidth : 567
                //     color: "gray"
                //     height: 1
                // }
                Rectangle{
                    width: 120
                    opacity: 0.65
                MyText {
                    id: lbroomid
                    text: Roomid
                    // text: "hhhh"
                    // color: Material.foreground
                    // elide: Text.ElideRight
                    // maximumLineCount: 1
                    width: 120
                    // wrapMode: Text.WrapAnywhere
                }}  
                // Button {
                //     id: inbtn2
                //     text:"tbn2"
                //     height: 15
                //     flat: true
                // }
                Rectangle{
                    width: 120
                    color: "red"
                    opacity: 0.5
                Text {
                    id: inbtn3
                    text: Mtimems
                    // flat: true
                    width: 120
                    color: Material.foreground
                }
                }
                }

                    Rectangle {
                        Layout.fillWidth: true
                        anchors.top : msgrow1.bottom
                        // width:350
                        width: parent.width-6
                        height: txtcc.contentHeight
                        // color: "#505050"
                        // color: window.color
                        color: Material.background
                        border.width: 3
                        // border.color: "#999"
                        id: txtcc2
                        

                    Text {
                        color: Material.foreground;
                    
                        id : txtcc
                        width: parent.width
                        // width: 350

                        text: Content
                        // text: "If this property is set to true, the layout will force all cells to have an uniform Height. The layout aims to respect";
                        wrapMode: Text.WrapAnywhere; 
                        }
                    }

                RowLayout {
                    anchors.top : txtcc2.bottom
                    Layout.fillWidth:false
                    height: 30
                    Rectangle{
                        width:120
                        opacity: 0.5
                    Text {
                        text: "jaefiaewjfowf"
                        color: Material.foreground
                        
                    }  }
                Rectangle{
                    width:120
                    opacity: 0.5
                Text {
                    id: labevtid
                    text: Eventid
                    // text: "hhhh"
                    color: Material.foreground
                    elide: Text.ElideRight
                    maximumLineCount: 1
                    width: 120
                    wrapMode: Text.WrapAnywhere
                    
                }}              
            }
            
            // Row{
            //     Layout.fillWidth: true
            //     width: parent.width

            //     Text {text: "name111";}
            //     Text {text: "chan111";}
            //     // Text {        color: Material.foreground;
            //     //  text: '<span style="loat: right;">titme111</span>' // "time111"; 
            //     //  horizontalAlignment:Text.AlignRight}
            //     Button {
            //     text:"tstpos"
            //     // anchors.right: parent.right
            //     // Layout.alignment: Qt.AlignRight
            //     }
            // }
            // Row {
            //     Layout.fillWidth: true
            //     width: parent.width
                
            // Text { text: "row1"; font.strikeout: true }
            // Rectangle {
            //     // width:350
            //     width: parent.width-40
            //     height: txtcc.contentHeight
            //     // color: "#505050"
            //     color: window.color
            //     border.width: 3
            //     // border.color: "#999"
            // Text {
            //     color: Material.foreground;
            
            //     id : txtcc
            //     width: parent.width
            //     // width: 350
            //     text: Content
            //     // text: "If this property is set to true, the layout will force all cells to have an uniform Height. The layout aims to respect";
            //      wrapMode: Text.WrapAnywhere; 
            //      }
            // }
            // }
            // Row {
            // Text { text: "row1"; color: Material.foreground; font.strikeout: true }
            // Text { text: "row2"; font.strikeout: true }
            // Text { text: "row3"; font.strikeout: true }
            // }
            // // Text { text: "row"; font.strikeout: true }
            // // Text { text: "row"; font.strikeout: true }

            // // Text { width: 66; text: Eventid; font.strikeout: true }
            // // Text { text: "row"; font.strikeout: true }
            // // Text { text: "row"; font.strikeout: true }
        }

        // delegate: TextArea {
        //     readOnly : true
        //     text: name + ": " + number
        // }
        // delegate: Text {
        //     text: name + ": " + number
        // }

    
    }

    // ComboBox {
    //     anchors.centerIn: parent

    //     // As currentValue was added in 2.14, the versioned import above
    //     // should cause this property to be used, but instead an error is produced:
    //     // "Cannot override FINAL property"
    //     // property int currentValue: 0
    // }

    // Text {
    //     anchors.centerIn: parent
    //     // anchors.fill: parent
    //     text: "test dark color"
    // }

    

    ///////// script
    // QmlCppBridge {    id : qcffi }

    // all functions are qt slots   
    function oncallqml(str) {
        Lib.debug(str);
        Lib.info("lstcnt", listView.count);  // print ui object property
    }

    Component.onCompleted: {
        // let rv = qcffi.invoke("thisqml");
        // Lib.debug(rv);
        listView.model.dummy()
        listView.model.append({name:"frommainqml", number: "frommainqml 909 545"})

        Lib.dummy('wt')
        Lib.util.dummy();
        // Jlib.default.dummy(); // TypeError: Cannot call method 'dummy' of undefined
    }
    //////
    function  onloadmsg () {
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
                    // listView.model.insert(0, item);
                }
                // listView.model.append({name:"frommainqml", number: "frommainqml 909 545"})
                // Lib.debug('typeof', typeof rv.Sender)
            }
            Lib.debug('itemcnt', listView.model.count);
        }
}