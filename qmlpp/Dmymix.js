.pragma library
// .js 被加载很多次的问题
// \see https://stackoverflow.com/questions/42483999/why-does-qml-engine-instantiate-the-same-script-multiple-times
let loadcnt = 0;
console.log("Dmymix.js: indmymix111", loadcnt, '.');


// try qml load .qml and .js mixed
// Usage: import "qmlpp";
// Dmymix.exports.dummymix()
// Dmymix.dummymix()
// Dmymix.dmymixfn();
// 可以识别var，以及function
// 不再需要显式的 import "dummy.js" as Dummy;
// 不能在qmldir里声明为singleton


/////////////

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


// 这个事件是加载过程最后触发的，来自CPP
function onQmlAppEngineCreated() {
    console.log("Dmymix.js:onQmlAppEngineCreated init sth.???");
}
