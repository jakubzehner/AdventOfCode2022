import gleam/set
import gleam/list
import gleam/int

import sensor
import common


pub fn count_not_beacon_positions(sensors: List(sensor.Sensor), at y: Int) -> Int {
  let sensors_coverage = sensors |> common.get_sensors_coverage(y) |> count_sensors_coverage
  let number_of_beacons_at_y = sensors |> get_beacons_at_y(y) |> set.from_list |> set.size

  sensors_coverage - number_of_beacons_at_y
}

fn get_beacons_at_y(sensors, y) {
  do_get_beacons_at_y(sensors, y, [])
}

fn do_get_beacons_at_y(sensors, y, result) {
  case sensors {
    [h, ..t] -> h |> sensor.get_beacon_at_y(y) |> list.append(result) |> do_get_beacons_at_y(t, y, _)
    [] -> result
  }
}

fn count_sensors_coverage(intervals) {
  do_count_sensors_coverage(intervals, 0)
}

fn do_count_sensors_coverage(intervals, sum) {
  case intervals {
    [#(a, b), ..t] -> do_count_sensors_coverage(t, int.absolute_value(b - a) + sum + 1)
    [] -> sum
  }
}
