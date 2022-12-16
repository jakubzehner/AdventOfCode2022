import gleam/int

pub opaque type Sensor {
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

pub fn coverage(sensor: Sensor, at y: Int) -> List(#(Int, Int)) {
  let Sensor(sx, sy, manhattan_length, _, _) = sensor

  case int.absolute_value(y - sy) {
    diff if diff <= manhattan_length -> [#(sx - manhattan_length + diff, sx + manhattan_length - diff)]
    _ -> []
  }
}

pub fn get_beacon_position(sensor: Sensor) -> #(Int, Int) {
  case sensor {
    Sensor(_, _, _, x, y) -> #(x, y)
  }
}

pub fn get_beacon_x_if_at_y(sensor: Sensor, at y: Int) -> List(Int) {
  case sensor {
    Sensor(_, _, _, bx, by) if by == y -> [bx]
    _ -> []
  }
}