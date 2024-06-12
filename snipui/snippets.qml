
// spaceitem
                Rectangle {
                    Layout.fillWidth:true
                    color: "red"
                    height: 3
                }


// 右对齐

           Rectangle {
                Layout.fillWidth: true
                color: "gray"
                // height: inbtn.height
                height: 90

                RowLayout{
                    anchors.right : parent.right
                    anchors.left : parent.left
                    Button {
                        id: inbtn
                        text:"tbn1"
                        // anchors.right: parent.right
                    }
                    Rectangle {
                        Layout.fillWidth:true
                        color: "red"
                        height: 3
                    }
                    Button {
                        id: inbtn2
                        // text:"in Rectangle"
                        text:"tbn2"
                        // anchors.right: parent.right
                    }
                }

            }
 

