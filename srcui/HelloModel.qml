
import QtQuick

// 实际测试，添加2w个ListElement
// 实际使用，改名为HelloModel.qml
// 排序怎么搞？
ListModel {
    id: helloModel

    ////////
    ListElement {
        Sender: "Bill Smith"
        Content: "555 3264"
        Roomid: ""
        Roomname: ""
        Feditype: ""
        Eventid: ""
        Mtimems: 0
        Mtimemsui: ''
        Dtime: "0s0ms"
    }
    // ListElement {
    //     name: "John Brown"
    //     number: "555 8426"
    // }
    // ListElement {
    //     name: "Sam Wise"
    //     Content: "<a href='http://hahhaha.com/ncr'>aaa</a>"
    // }


    ///////
    function dummy() { console.log("dummy: this ListModel") }

    
    function addtstitems() {
        for (let i=0;i < 12; i++) {
        // this.append({name:"nam"+i, number: "num 444 555 "+i})
        }
    }
    Component.onCompleted: {
        addtstitems();
    }
}
