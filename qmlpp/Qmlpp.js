// try qml load .qml and .js mixed
// Usage: import "qmlpp";
// Dmymix.exports.dummymix()
// Dmymix.dummymix()
// Dmymix.dmymixfn();
// 可以识别var，以及function
// 不再需要显式的 import "dummy.js" as Dummy;
// 不能在qmldir里声明为singleton

var exports = {};

"use strict";
//

// not work syntax
// export function dummymix2() {
//     console.log("global func dummymix222");
// }

// function dummymix() {
//     console.log("global func dummymix");
// }
// exports.dummymix = dummymix;

/////
function qmlTimer() {
    // return Qt.createComponent("import QtQuick; Timer{}", appwin);
    return Qt.createQmlObject("import QtQuick; Timer{}", appwin);
}
function qmlSetTimeout(cbfn, delay, ...args) {
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
function qmlClearTimeout(tmer) {
    // console.log("clrtmer", tmer);
    // tmer.running = false;
    tmer.stop();
    // tmer.disconnect(); // not work
    tmer.destroy();
}
