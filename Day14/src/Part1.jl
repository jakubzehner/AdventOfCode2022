function findNextPositionAbyss(points, spawnPoint, maxDeep)
    cordinates = findNextPosition(points, spawnPoint, maxDeep)
    return cordinates[2] == maxDeep ? (-1, -1) : cordinates
end

function sandUnitsBeforeAbyss(pointsSet, spawnPoint)
    points = deepcopy(pointsSet)
    maxDeep = findMaxDeep(points)
    positionFinder = pts -> findNextPositionAbyss(pts, spawnPoint, maxDeep)
    return countSandUnits(points, positionFinder)
end
