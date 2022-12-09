source("Common.r")
source("Part1.r")

file_name <- "../inputs/test.txt"

motions <- read_input(file_name)
# print(motions)
print(count_tail_positions(motions))