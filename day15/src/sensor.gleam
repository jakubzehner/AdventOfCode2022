import gleam/int
import gleam/list

pub type Sensor {
  Sensor(x: Int, y: Int, manhattan_length: Int, beacon_x: Int, beacon_y: Int)
}

pub fn new(sensor_x: Int, sensor_y: Int, beacon_x: Int, beacon_y: Int) {
  Sensor(
    sensor_x,
    sensor_y,
    calculate_manhattan_length(sensor_x, sensor_y, beacon_x, beacon_y),
    beacon_x,
    beacon_y
  )
}

fn calculate_manhattan_length(
  start_x: Int,
  start_y: Int,
  end_x: Int,
  end_y: Int,
) {
  int.absolute_value(start_x - end_x) + int.absolute_value(start_y - end_y)
}

pub fn coverage(sensor: Sensor, at y: Int) -> List(Int) {
  let Sensor(_, _, _, beacon_x, beacon_y) = sensor
  case beacon_y {
    beacon_y if beacon_y == y -> {
      calculate_coverage(sensor, y)
      |> list.filter(fn(x) {x != beacon_x})
    }
    _ -> calculate_coverage(sensor, y)
  }
}

pub fn calculate_coverage(sensor: Sensor, y: Int) -> List(Int) {
  let Sensor(sx, sy, manhattan_length, _, _) = sensor

  case int.absolute_value(y - sy) {
    diff if diff <= manhattan_length -> list.range(sx - manhattan_length + diff, sx + manhattan_length - diff)
    _ -> []
  }
}