function mostPossiblePreassure(flows, distances, timeLeft, startPosition, openedValves = [], memo = {}) {
    function findMaxPreassure(timeLeft, current, openedValves) {
        const key = timeLeft + ";" + current + ";" + openedValves.sort().toString()
        if (key in memo) {
            return memo[key];
        }

        let result = 0;
        for (const next in distances[current]) {
            if (openedValves.includes(next)) continue;
            const nextTimeLeft = timeLeft - distances[current][next] - 1
            if (nextTimeLeft <= 0) continue;

            result = Math.max(result, flows[next] * nextTimeLeft + findMaxPreassure(nextTimeLeft, next, [next, ...openedValves]))
        }

        memo[key] = result;
        return result;
    }

    return findMaxPreassure(timeLeft, startPosition, openedValves);
}

export default mostPossiblePreassure;