require "./Common"

FILE_NAME = "inputs/input.txt"
ROUNDS_PART1 = 20
STRESS_DIVIDER_PART1 = 3
ROUNDS_PART2  = 10000
STRESS_DIVIDER_PART2 = 1

monkeys = readInput(FILE_NAME)
puts monkeyBusinessAfterRounds(monkeys, ROUNDS_PART1, STRESS_DIVIDER_PART1)
monkeys = readInput(FILE_NAME)
puts monkeyBusinessAfterRounds(monkeys, ROUNDS_PART2, STRESS_DIVIDER_PART2)