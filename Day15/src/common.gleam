import gleam/erlang/file
import gleam/string
import gleam/int
import gleam/order
import gleam/list

import sensor


pub fn read_input(file_name: String) -> List(sensor.Sensor) {
  assert Ok(contents) = file.read(file_name)
  parse_input(contents)
}

fn parse_input(contents) {
  contents
  |> string.split(on: "\n")
  |> parse_input_lines([])
}

fn parse_input_lines(lines, result) {
  case lines {
    [line, ..tail] -> line |> parse_input_line |> list.prepend(result, _) |> parse_input_lines(tail, _)
    [] -> result
  }
}

fn parse_input_line(line) {
  assert Ok(#(sensor_string, beacon_string)) = string.split_once(line, on: ": ")
  let #(sensor_x, sensor_y) = sensor_string |> string.crop(before: "x=") |> string_cordinates_to_position
  let #(beacon_x, beacon_y) = beacon_string |> string.crop(before: "x=") |> string_cordinates_to_position
  sensor.new(sensor_x, sensor_y, beacon_x, beacon_y)
}

fn string_cordinates_to_position(cordinates) {
  assert Ok(#(x_string, y_string)) = string.split_once(cordinates, on: ", ")
  assert Ok(x) = x_string |> string.drop_left(up_to: 2) |> string.trim |> int.parse
  assert Ok(y) = y_string |> string.drop_left(up_to: 2) |> string.trim |> int.parse
  #(x, y)
}

pub fn int_pair_comparator(a: #(Int, Int), b: #(Int, Int)) {
  case int.compare(a.0, b.0) {
    order.Eq -> int.compare(a.1, b.1)
    order -> order
  }
}

pub fn get_sensors_coverage(sensors: List(sensor.Sensor), at y: Int) -> List(#(Int, Int)) {
  sensors
  |> do_get_sensors_coverage(y, [])
  |> list.sort(int_pair_comparator)
  |> merge_sorted_intervals([])
}

fn do_get_sensors_coverage(sensors, y, intervals) {
  case sensors {
    [h, ..t] -> h |> sensor.coverage(at: y) |> list.append(intervals) |> do_get_sensors_coverage(t, y, _)
    [] -> intervals
  }
}

fn merge_sorted_intervals(intervals: List(#(Int, Int)), merged: List(#(Int, Int))) {
  case intervals, merged {
    [r, ..tr], [m, ..tm] if m.1 >= r.1 -> merge_sorted_intervals(tr, [m, ..tm])
    [r, ..tr], [m, ..tm] if m.1 >= r.0 -> merge_sorted_intervals(tr, [#(m.0, r.1), ..tm])
    [r, ..tr], m -> merge_sorted_intervals(tr, [r, ..m])
    [], m -> m
  }
}