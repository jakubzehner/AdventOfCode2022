source("Common.r")
source("Part1.r")
source("Part2.r")

file_name <- "../inputs/input.txt"

motions <- read_input(file_name)
# print(motions)
print(count_tail_positions(motions))
print(count_long_tail_positions(motions))