function findNextPosition1(points, spawnPoint, maxDeep)
    cords = spawnPoint

    if in(spawnPoint, points)
        return (-1, -1)
    end

    foundNextCord = false
    while !foundNextCord
        if !in((cords[1], cords[2] + 1), points)
            cords = (cords[1], cords[2] + 1)
        elseif !in((cords[1] - 1, cords[2] + 1), points)
            cords = (cords[1] - 1, cords[2] + 1)
        elseif !in((cords[1] + 1, cords[2] + 1), points)
            cords = (cords[1] + 1, cords[2] + 1)
        else 
            foundNextCord = true
        end
        if cords[2] == maxDeep
            foundNextCord = true
        end
    end
    return cords
end

function sandUnitsOnFloor(pointsSet, spawnPoint)
    points = deepcopy(pointsSet)
    sandUnits = 0

    maxDeep = spawnPoint[2]
    for point in points
        if point[2] > maxDeep
            maxDeep = point[2]
        end
    end
    maxDeep += 1
    
    while true
        sandPosition = findNextPosition1(points, spawnPoint, maxDeep)
        if sandPosition == (-1, -1)
            break
        end
        push!(points, sandPosition)
        sandUnits += 1
    end
    
    return sandUnits
end