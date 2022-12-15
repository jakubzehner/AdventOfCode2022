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