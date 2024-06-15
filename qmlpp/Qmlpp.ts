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

