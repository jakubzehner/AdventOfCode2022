import sensor
import common

pub fn find_tuning_frequency(sensors: List(sensor.Sensor), between range: #(Int, Int)) -> Int {
  let #(x, y) = find_beacon_position(sensors, range, range.0)
  x * 4000000 + y
}

fn find_beacon_position(sensors, range, y_counter) {
  case check_for_beacon_at(sensors, range, y_counter) {
    -1 -> find_beacon_position(sensors, range, y_counter + 1)
    x -> #(x, y_counter)
  }
}

fn check_for_beacon_at(sensors, range, y) {
  sensors
  |> common.get_sensors_coverage(y)
  |> trim_intervals(range, [])
  |> try_to_find_beacon
}

fn try_to_find_beacon(intervals) {
  case intervals {
    [interval, _] -> interval.1 + 1
    _ -> -1
  }
}

fn trim_intervals(intervals, range, trimed) -> List(#(Int, Int)) {
  case intervals {
    [interval, ..t] if interval.1 > range.1 && interval.0 < range.0 -> trim_intervals(t, range, [#(range.0, range.1), ..trimed])
    [interval, ..t] if interval.1 > range.1 -> trim_intervals(t, range, [#(interval.0, range.1), ..trimed])
    [interval, ..t] if interval.0 < range.0 -> trim_intervals(t, range, [#(range.0, interval.1), ..trimed])
    [_, ..t] -> trim_intervals(t, range, trimed)   
    [] -> trimed
  }
}
