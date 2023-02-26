module part1

import common

fn count_bits(number u8) int {
	mut count := 0
	mut n := number

	for n != 0 {
		count += n & 1
		n >>>= 1
	}

	return count
}

fn try_to_shift(direction common.Direction, part_of_chamber []u8, mut shape []u8) {
	assert part_of_chamber.len == shape.len

	mut shifted_shape := shape.clone()
	size := shape.len

	for i in 0 .. size {
		match direction {
			.left { shifted_shape[i] <<= 1 }
			.right { shifted_shape[i] >>>= 1 }
		}
	}

	// check overflow to the left
	if shifted_shape.any(it & u8(0b1_0000000) != 0) {
		return
	}

	// check overflow to the right
	for i in 0 .. size {
		if count_bits(shifted_shape[i]) != count_bits(shape[i]) {
			return
		}
	}

	// check collision
	for i in 0 .. size {
		if shifted_shape[i] & part_of_chamber[i] != 0 {
			return
		}
	}

	// shift
	shape = shifted_shape.clone()
}

fn can_fall(part_of_chamber []u8, shape []u8) bool {
	if part_of_chamber.len < shape.len {
		return false
	}

	for i in 0 .. shape.len {
		if part_of_chamber[i] & shape[i] != 0 {
			return false
		}
	}
	return true
}

fn settle(mut part_of_chamber []u8, shape []u8) {
	assert part_of_chamber.len == shape.len
	for i in 0 .. shape.len {
		part_of_chamber[i] |= shape[i]
	}
}

fn trim_chamber(mut chamber []u8) {
	for chamber.len != 0 && chamber.last() == 0 {
		chamber.delete_last()
	}
}

fn add_rock(original_shape []u8, mut chamber []u8, mut directions common.Directions) {
	mut shape := original_shape.clone()
	mut level := 1

	for _ in 0 .. 3 + 1 + shape.len {
		chamber << 0
	}

	mut is_falling := true
	for is_falling {
		try_to_shift(directions.next(), chamber#[-(shape.len + level)..-level], mut shape)
		if can_fall(chamber#[-(shape.len + level + 1)..-(level + 1)], shape) {
			level += 1
		} else {
			settle(mut chamber#[-(shape.len + level)..-level], shape)
			is_falling = false
		}
	}

	trim_chamber(mut chamber)
}

pub fn solve(mut directions common.Directions, number_of_rocks_part_1 int) int {
	mut shapes := common.Shapes{}
	mut chamber := []u8{}

	for _ in 0 .. number_of_rocks_part_1 {
		add_rock(shapes.next(), mut chamber, mut directions)
	}

	return chamber.len
}
