module common

import os

pub enum Direction {
	left
	right
}

pub struct Directions {
	directions []Direction
mut:
	n int
}

pub fn (mut d Directions) next() Direction {
	direction := d.directions[d.n]
	d.n += 1
	d.n = d.n % d.directions.len
	return direction
}

pub fn (d Directions) length() int {
	return d.directions.len
}

fn char_to_direction(ch u8) Direction {
	left_char := u8(0x3C) // '<'
	if ch == left_char {
		return Direction.left
	} else {
		return Direction.right
	}
}

pub fn read_input(file_name string) !Directions {
	lines := os.read_lines(file_name)!
	line := lines[0]

	directions := line.bytes().map(char_to_direction)

	return Directions{
		directions: directions
	}
}

pub struct Shapes {
	shapes [][]u8 = [[u8(0b0_0011110)], [u8(0b0_0001000), u8(0b0_0011100), u8(0b0_0001000)],
					[u8(0b0_0011100), u8(0b0_0000100), u8(0b0_0000100)],
					[u8(0b0_0010000), u8(0b0_0010000), u8(0b0_0010000), u8(0b0_0010000)],
					[u8(0b0_0011000), u8(0b0_0011000)]]
mut:
	n int
}

pub fn (mut s Shapes) next() []u8 {
	shape := s.shapes[s.n]
	s.n += 1
	s.n = s.n % s.shapes.len
	return shape
}

fn count_bits(number u8) int {
	mut count := 0
	mut n := number

	for n != 0 {
		count += n & 1
		n >>>= 1
	}

	return count
}

fn try_to_shift(direction Direction, part_of_chamber []u8, mut shape []u8) {
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

pub fn add_rock(original_shape []u8, mut chamber []u8, mut directions Directions) {
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