import gleam/set

import sensor

pub fn count_not_beacon_positions(sensors: List(sensor.Sensor), at y: Int) -> Int {
  count_not_beacon_positions_rec(sensors, y, set.new())
}

fn count_not_beacon_positions_rec(sensors: List(sensor.Sensor), y: Int, sensors_set: set.Set(Int)) -> Int {
  case sensors {
    [head, ..tail] -> count_not_beacon_positions_rec(tail, y, set.union(sensors_set, set.from_list(sensor.coverage(head, at: y))))
    [] -> set.size(sensors_set)
  }
}