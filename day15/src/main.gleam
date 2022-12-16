import gleam/io
import gleam/int

import common
import part1

pub const file_name = "./inputs/input.txt"

pub const row_y_test_part1 = 10
pub const row_y_part1 = 2000000



pub fn main() {
  let sensors = common.read_input(file_name)
  
  sensors
  |> part1.count_not_beacon_positions(at: row_y_part1)
  |> int.to_string
  |> io.println
}