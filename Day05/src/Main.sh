#!/bin/bash

source $(dirname "$0")/Common.sh
source $(dirname "$0")/Part1.sh

# File have to end with empty line, otherwise there is problem with reading last line
FILE_NAME="$(dirname "$0")/../inputs/test.txt"

read_input $FILE_NAME array_of_moves number_of_stacks

# Part 1
moveItems array_of_moves
getStacksTops number_of_stacks stacksTops
echo $stacksTops
