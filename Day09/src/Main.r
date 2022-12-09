source("Common.r")

file_name <- "../inputs/input.txt"
knots_number_part1 <- 2
knots_number_part2 <- 10

motions <- read_input(file_name)

print(count_tail_positions(motions, knots_number_part1))
print(count_tail_positions(motions, knots_number_part2))