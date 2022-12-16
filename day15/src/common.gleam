import gleam/erlang/file
import gleam/string
import gleam/int
import sensor

pub fn read_input(file_name: String) -> List(sensor.Sensor) {
  assert Ok(contents) = file.read(file_name)
  contents
  |> parse_input
}

fn parse_input(contents) -> List(sensor.Sensor) {
  contents
  |> string.split(on: "\n")
  |> parse_input_lines([])
}

fn parse_input_lines(lines: List(String), result: List(sensor.Sensor)) -> List(sensor.Sensor) {
  case lines {
    [line, ..tail] -> parse_input_lines(tail, [parse_input_line(line), ..result])
    [] -> result
  }
}

fn parse_input_line(line: String) -> sensor.Sensor {
  assert Ok(#(sensor_string, beacon_string)) = string.split_once(line, on: ": ")
  let #(sensor_x, sensor_y) = string_cordinates_to_position(string.crop(from: sensor_string, before: "x="))
  let #(beacon_x, beacon_y) = string_cordinates_to_position(string.crop(from: beacon_string, before: "x="))
  sensor.new(sensor_x, sensor_y, beacon_x, beacon_y)
}

fn string_cordinates_to_position(cordinates: String) -> #(Int, Int) {
  assert Ok(#(x_string, y_string)) = string.split_once(cordinates, on: ", ")
  let x_string = string.trim(string.drop_left(from: x_string, up_to: 2))
  let y_string = string.trim(string.drop_left(from: y_string, up_to: 2))
  assert Ok(x) = int.parse(x_string)
  assert Ok(y) = int.parse(y_string)
  #(x, y)
}