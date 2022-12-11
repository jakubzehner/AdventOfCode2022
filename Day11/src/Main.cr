require "./Common"
require "./Part1"

FILE_NAME = "inputs/input.txt"
ROUNDS = 20

monkeys = readInput(FILE_NAME)
puts monkeyBusinessAfterRounds(monkeys, ROUNDS)