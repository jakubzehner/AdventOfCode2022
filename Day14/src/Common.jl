function generatePoints(startPoint, endPoint)
    xS, yS = split(startPoint, ",")
    xE, yE = split(endPoint, ",")
    xS, xE, yS, yE = parse(Int64, xS), parse(Int64, xE), parse(Int64, yS), parse(Int64, yE)
    diffX = xE - xS
    diffY = yE - yS

    points = []
    for i in 0:max(abs(diffX), abs(diffY))
        push!(points, (xS + i * sign(diffX), yS + i * sign(diffY)))
    end

    return points
end

function parseInputLine(line)
    points = []
    cords = split(line, " -> ")
    for i in 1:size(cords, 1) - 1
        points = vcat(points, generatePoints(cords[i], cords[i + 1]))
    end
    return points
end

function readInput(path)
    pointsSet = Set{Tuple{Int64, Int64}}()
    open(path) do file
        while !eof(file)
            line = readline(file)
            union!(pointsSet, parseInputLine(line))
        end
    end
    return pointsSet
end

function findMaxDeep(points)
    return reduce((acc, elem) -> max(acc, elem[2]), points, init=0)
end    

function countSandUnits(points, positionFinder)
    sandUnits = 0
    while true
        sandPosition = positionFinder(points)
        if sandPosition == (-1, -1)
            break
        end
        push!(points, sandPosition)
        sandUnits += 1
    end
    return sandUnits
end

oneBelow = cordinates -> (cordinates[1], cordinates[2] + 1)
oneBelowToTheLeft = cordinates -> (cordinates[1] - 1, cordinates[2] + 1)
oneBelowToTheRight = cordinates -> (cordinates[1] + 1, cordinates[2] + 1)

function findNextPosition(points, cordinates, maxDeep)
    foundNextCord = false
    while !foundNextCord
        if !in(oneBelow(cordinates), points)
            cordinates = oneBelow(cordinates)
        elseif !in(oneBelowToTheLeft(cordinates), points)
            cordinates = oneBelowToTheLeft(cordinates)
        elseif !in(oneBelowToTheRight(cordinates), points)
            cordinates = oneBelowToTheRight(cordinates)
        else
            foundNextCord = true
        end
        if cordinates[2] == maxDeep
            foundNextCord = true
        end
    end
    return cordinates
end