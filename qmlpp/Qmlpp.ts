// .pragma library
// var exports = {};

// try qml load .qml and .js mixed
// 在 qmldir 文件中添加: Qmlpp 1.0 Qmlpp.js
// Usage: import "qmlpp";
// Dmymix.exports.dummymix()
// Dmymix.dummymix()
// Dmymix.dmymixfn();
// 可以识别var，以及function
// 不再需要显式的 import "dummy.js" as Dummy;
// 不能在qmldir里声明为singleton

// 必须要这一行
// var exports = {};

// "use strict";
// //

// // not work syntax
// // export function dummymix2() {
// //     console.log("global func dummymix222");
// // }

// function dummymix() {
//     console.log("global func dummymix");
// }
// exports.dummymix = dummymix;

// import QtQml

// tsc 搜索 type 的路径
// tsc --types Qt  qmlpp/Qmlpp.ts
// ./node_modules/\@types/Qt/index.d.ts

/////
let loadcnt = 0;
console.log("Qmlpp.ts: multiload check", loadcnt);

/////
var qmlappwin :any = null;

export function qmlppinit(win) {
    qmlappwin = win;
}

export function qmlTimer() {
    // return Qt.createComponent("import QtQuick; Timer{}", appwin);
    return Qt.createQmlObject("import QtQuick; Timer{}", qmlappwin);
}

export function qmlSetTimeout(cbfn, delay, ...args) {
    // console.log(cbfn, delay, ...args);
    let tmer = qmlTimer();
    tmer.interval = delay;
    tmer.repeat = true; // like origin setTimeout
    let cb = () => { cbfn(...args); };
    tmer.triggered.connect(cb);
    // tmer.running = true;
    tmer.start();
    return tmer
}
export function qmlClearTimeout(tmer) {
    // console.log("clrtmer", tmer);
    // tmer.running = false;
    tmer.stop();
    // tmer.disconnect(); // not work
    tmer.destroy();
}