
import QtQuick

// 实际测试，添加2w个ListElement
// 实际使用，改名为HelloModel.qml
ListModel {
    id: helloModel

    ////////
    ListElement {
        name: "Bill Smith"
        number: "555 3264"
        Content: ""
        Roomid: ""
        Roomname: ""
        Feditype: ""
        Eventid: ""
    }
    ListElement {
        name: "John Brown"
        number: "555 8426"
    }
    ListElement {
        name: "Sam Wise"
        number: "555 0473"
    }


    ///////
    function dummy() { console.log("dummy: this ListModel") }
    function addtstitems() {
        for (let i=0;i < 12; i++) {
        this.append({name:"nam"+i, number: "num 444 555 "+i})
        }
    }
    Component.onCompleted: {
        addtstitems();
    }
}
