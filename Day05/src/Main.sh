#!/bin/bash

source $(dirname "$0")/Common.sh
source $(dirname "$0")/Part1.sh
source $(dirname "$0")/Part2.sh

# File have to end with empty line, otherwise there is problem with reading last line
FILE_NAME="$(dirname "$0")/../inputs/test.txt"

# Part 1
read_input $FILE_NAME array_of_moves number_of_stacks
moveItemsOneByOne array_of_moves
getStacksTops number_of_stacks stacksTops
echo $stacksTops

wipeData $number_of_stacks

# Part 2
read_input $FILE_NAME array_of_moves number_of_stacks
moveFewItemsAtOnce array_of_moves
getStacksTops number_of_stacks stacksTops
echo $stacksTops