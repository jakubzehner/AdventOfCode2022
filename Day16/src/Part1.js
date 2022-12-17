function mostPossiblePreassure(adjatencyMap, TIME, startPosition) {
    const distances = getDistanceMatrix(adjatencyMap);
    function findMaxPossiblePreassure(timeLeft, current, closedValves) {
        const subResults = [0];

        for (const next in adjatencyMap) {
            if (closedValves.includes(next)) continue;
            if (adjatencyMap[next]["flow"] == 0) continue;

            const nextTimeLeft = timeLeft - distances[current][next] - 1;
            if (nextTimeLeft < 0) continue;

            const releasedPressure = nextTimeLeft * adjatencyMap[next]["flow"];
            subResults.push(releasedPressure + findMaxPossiblePreassure(nextTimeLeft, next, [next, ...closedValves]));
        }

        return Math.max(...subResults);
    }

    return findMaxPossiblePreassure(TIME, startPosition, []);
}

function getDistanceMatrix(adjatencyMap) {
    const distances = {};
    for (const node in adjatencyMap) {
        distances[node] = distanceToEachNodeFrom(adjatencyMap, node);
    }
    return distances;
}

function distanceToEachNodeFrom(adjatencyMap, start) {
    const distances = {};
    const visited = {};
    const queue = [];

    for (const key in adjatencyMap) {
        distances[key] = Number.MAX_SAFE_INTEGER;
        visited[key] = false;
    }

    visited[start] = true;
    distances[start] = 0;
    queue.push(start);

    while (queue.length) {
        const curr = queue.shift()
        for (const nextNode of adjatencyMap[curr]["neighbours"]) {
            if (visited[nextNode]) continue;
            visited[nextNode] = true;
            distances[nextNode] = distances[curr] + 1;
            queue.push(nextNode);
        }
    }

    return distances;
}

export default mostPossiblePreassure;