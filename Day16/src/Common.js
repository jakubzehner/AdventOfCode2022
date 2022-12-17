import * as fileSync from "fs";

function readInput(fileName) {
    return fileSync.readFileSync(fileName)
        .toString()
        .split("\n")
        .map(line => line.trim())
        .map(lineToObject)
        .reduce(objectToAdjatency, {});
}

function lineToObject(line) {
    const valve = line.slice(6, 8);
    const flow = parseInt(line.slice(23, line.indexOf(";")));
    const neighbours = line.slice(line.indexOf(";") + 24).trim().split(", ");
    return {"valve": valve, "flow": flow, "neighbours": neighbours};
}

function objectToAdjatency(acc, curr) {
    acc[curr["valve"]] = {"flow": curr["flow"], "neighbours": curr["neighbours"]};
    return acc;
}

export default readInput;