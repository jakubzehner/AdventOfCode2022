require_relative "Common"

FILE_NAME = File.dirname(__FILE__) + "/../inputs/test.txt"
PART1_SEQ_LEN = 4
PART2_SEQ_LEN = 14

input = readInput(FILE_NAME)
puts findStartMarkerPosition(input, PART1_SEQ_LEN)
puts findStartMarkerPosition(input, PART2_SEQ_LEN)