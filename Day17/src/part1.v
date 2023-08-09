module part1

import common

pub fn solve(mut directions common.Directions, number_of_rocks int) int {
	mut shapes := common.Shapes{}
	mut chamber := []u8{}

	for _ in 0 .. number_of_rocks {
		common.add_rock(shapes.next(), mut chamber, mut directions)
	}

	return chamber.len
}
