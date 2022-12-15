function findNextPositionFloor(points, spawnPoint, maxDeep)
    return in(spawnPoint, points) ? (-1, -1) : findNextPosition(points, spawnPoint, maxDeep)
end

function sandUnitsOnFloor(pointsSet, spawnPoint)
    points = deepcopy(pointsSet)
    maxDeep = findMaxDeep(points) + 1
    positionFinder = pts -> findNextPositionFloor(pts, spawnPoint, maxDeep)
    return countSandUnits(points, positionFinder)
end
