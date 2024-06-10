
import QtQuick

// 实际测试，添加2w个ListElement
// 实际使用，改名为HelloModel.qml
ListModel {
    id: helloModel

    ////////
    ListElement {
        name: "Bill Smith"
        number: "555 3264"
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
    function dummy() { console.log("hahhehe") }
    function addtstitems() {
        for (let i=0;i < 123456; i++) {
        this.append({name:"nam"+i, number: "num 444 555 "+i})
        }
    }
    Component.onCompleted: {
        addtstitems();
    }
}
