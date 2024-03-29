module main

import common
import part1

fn main() {
	file_name := './inputs/test.txt'
	number_of_rocks_part_1 := 2022
	number_of_rocks_part_2 := i64(1_000_000_000_000)

	mut directions := common.read_input(file_name)!

	println(part1.solve(mut directions, number_of_rocks_part_1))
}
