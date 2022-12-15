include("Common.jl")
include("Part1.jl")
include("Part2.jl")

FILE_NAME = "../inputs/test.txt"
SAND_SPAWN_POINT = (500, 0)

pointsSet = readInput(FILE_NAME)
println(sandUnitsBeforeAbyss(pointsSet, SAND_SPAWN_POINT))
println(sandUnitsOnFloor(pointsSet, SAND_SPAWN_POINT))