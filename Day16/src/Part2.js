import mostPossiblePreassure from "./Part1.js";

function mostPossiblePreassureWithElephant(flows, distances, timeLeft, startPosition) {
    const memo = {};
    
    const notBlockedValves = [];
    for (const valve in flows) {
        if (flows[valve] > 0) {
            notBlockedValves.push(valve);
        }
    }

    let result = 0;
    for (const pair of partition(notBlockedValves)) {
        const myResult = mostPossiblePreassure(flows, distances, timeLeft, startPosition, pair[0], memo);
        const elephantResult = mostPossiblePreassure(flows, distances, timeLeft, startPosition, pair[1], memo);
        
        result = Math.max(result, myResult + elephantResult);
    }

    return result;
}

function partition(list) {
    if (list.length === 0) {
        return [[[], []]];
    }
    const first = list[0];
    const rest = list.slice(1);
    const partitions = partition(rest);
    const result = [];
    for (let i = 0; i < partitions.length; i++) {
        const p = partitions[i];
        result.push([[first].concat(p[0]), p[1]]);
        result.push([p[0], [first].concat(p[1])]);
    }
    return result;
}

export default mostPossiblePreassureWithElephant;