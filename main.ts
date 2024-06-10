


export function dummy() {
    console.log("global func dummy");
}

export class util {
    static dummy() {
        console.log("class static func dummy");
    }
}

export default {
    dummy() {
        console.log("default func dummy");
    }
}