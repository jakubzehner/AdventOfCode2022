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

pub fn (mut d Directions) reset() {
	d.n = 0
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
