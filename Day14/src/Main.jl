include("Common.jl")
include("Part1.jl")

FILE_NAME = "../inputs/input.txt"
SAND_SPAWN_POINT = (500, 0)

pointsSet = readInput(FILE_NAME)
println(sandUnitsBeforeAbyss(pointsSet, SAND_SPAWN_POINT))