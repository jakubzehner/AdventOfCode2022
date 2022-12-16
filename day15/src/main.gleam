import gleam/io
import gleam/int

import common
import part1
import part2


pub const file_name = "./inputs/test.txt"

pub const row_y_part1_test = 10
pub const row_y_part1 = 2000000

pub const range_part2_test = #(0, 20)
pub const range_part2 = #(0, 4000000)


pub fn main() {
  let sensors = common.read_input(file_name)

  sensors
  |> part1.count_not_beacon_positions(at: row_y_part1_test)
  |> int.to_string
  |> io.println

  sensors
  |> part2.find_tuning_frequency(between: range_part2_test)
  |> int.to_string
  |> io.println
}
