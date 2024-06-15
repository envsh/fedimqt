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

function dummymix() {
    console.log("global func dummymix");
}
exports.dummymix = dummymix;

var dmymixfn = function () {
    console.log("global func dmymixfn");
}

console.log("indmymix");


// 这个事件是加载过程最后触发的，来自CPP
function onQmlAppEngineCreated() {
    console.log("Dmymix.js:onQmlAppEngineCreated init sth.???");
}
