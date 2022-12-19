import * as fileSync from "fs";

function readInput(fileName) {
    const input = fileSync.readFileSync(fileName)
        .toString()
        .split("\n")
        .map(line => line.trim())
        .map(lineToObject)

    const flows = flowsFromInput(input);
    return [flows, findDistances(flows, neighboursFromInput(input))];
}

function lineToObject(line) {
    const valve = line.slice(6, 8);
    const flow = parseInt(line.slice(23, line.indexOf(";")));
    const neighbours = line.slice(line.indexOf(";") + 24).trim().split(", ");
    return { "valve": valve, "flow": flow, "neighbours": neighbours };
}

function flowsFromInput(input) {
    const flows = {};
    for (const valve of input) {
        flows[valve["valve"]] = valve["flow"];
    }
    return flows;
}

function neighboursFromInput(input) {
    const neighbours = {};
    for (const valve of input) {
        neighbours[valve["valve"]] = valve["neighbours"];
    }
    return neighbours;
}

function findDistances(flows, neighbours) {
    const distances = {};

    function findShortestPathsFrom(start) {
        const distance = {};
        const visited = [];
        const queue = [];

        distance[start] = 0;
        visited.push(start);
        queue.push(start);

        while (queue.length > 0) {
            const curr = queue.shift();
            for (const next of neighbours[curr]) {
                if (visited.includes(next)) continue;
                visited.push(next);
                queue.push(next);
                distance[next] = distance[curr] + 1;
            }
        }
        for (const key in distance) {
            if (flows[key] == 0) {
                delete distance[key];
            }
        }
        delete distance[start];
        return distance;
    }

    for (const node in flows) {
        distances[node] = findShortestPathsFrom(node);
    }

    return distances
}

export { readInput }