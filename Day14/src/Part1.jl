function findNextPosition(points, spawnPoint, maxDeep)
    cords = spawnPoint

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
        if cords[2] >= maxDeep
            cords = (-1, -1)
            foundNextCord = true
        end
    end
    # print(cords)
    return cords
end

function sandUnitsBeforeAbyss(pointsSet, spawnPoint)
    points = deepcopy(pointsSet)
    sandUnits = 0

    maxDeep = spawnPoint[2]
    for point in points
        if point[2] > maxDeep
            maxDeep = point[2]
        end
    end
    maxDeep
    
    while true
        sandPosition = findNextPosition(points, spawnPoint, maxDeep)
        if sandPosition == (-1, -1)
            break
        end
        push!(points, sandPosition)
        sandUnits += 1
    end
    
    return sandUnits
end