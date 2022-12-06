require_relative "Common"
require_relative "Part1"

FILE_NAME = File.dirname(__FILE__) + "/../inputs/input.txt"
PART1_SEQ_LEN = 4

input = readInput(FILE_NAME)
puts findStartMarkerPosition input, PART1_SEQ_LEN