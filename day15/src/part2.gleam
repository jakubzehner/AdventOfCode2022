import gleam/list
import gleam/int
import gleam/order
import sensor

pub fn find_tuning_frequency(
  sensors: List(sensor.Sensor),
  between range: #(Int, Int),
) -> Int {
  let #(x, y) = find_beacon_position(sensors, range, range.0)
  x * 4000000 + y
}

fn find_beacon_position(
  sensors: List(sensor.Sensor),
  range: #(Int, Int),
  y_counter: Int,
) -> #(Int, Int) {
  case check_for_beacon_at(sensors, range, y_counter) {
    -1 -> find_beacon_position(sensors, range, y_counter + 1)
    x -> #(x, y_counter)
  }
}

fn check_for_beacon_at(
  sensors: List(sensor.Sensor),
  range: #(Int, Int),
  y: Int,
) -> Int {
  get_not_beacon_ranges(sensors, y, [])
  |> merge_intervals
  |> trim_intervals(range, [])
  |> try_to_find_beacon
}

fn try_to_find_beacon(intervals: List(#(Int, Int))) -> Int {
  case intervals {
    [interval, _] -> interval.1 + 1
    _ -> -1
  }
}

fn trim_intervals(
  intervals: List(#(Int, Int)),
  range: #(Int, Int),
  trimed: List(#(Int, Int)),
) -> List(#(Int, Int)) {
  case intervals {
    [interval, ..t] if interval.1 > range.1 && interval.0 < range.0 ->
      trim_intervals(t, range, [#(range.0, range.1), ..trimed])
    [interval, ..t] if interval.0 > range.1 -> trim_intervals(t, range, trimed)
    [interval, ..t] if interval.1 > range.1 ->
      trim_intervals(t, range, [#(interval.0, range.1), ..trimed])
    [interval, ..t] if interval.1 < range.0 -> trim_intervals(t, range, trimed)
    [interval, ..t] if interval.0 < range.0 ->
      trim_intervals(t, range, [#(range.0, interval.1), ..trimed])
    [] -> trimed
  }
}

fn get_not_beacon_ranges(
  sensors: List(sensor.Sensor),
  y: Int,
  ranges: List(#(Int, Int)),
) -> List(#(Int, Int)) {
  case sensors {
    [head, ..tail] ->
      get_not_beacon_ranges(
        tail,
        y,
        list.append(sensor.coverage(head, at: y), ranges),
      )
    [] -> ranges
  }
}

fn merge_intervals(ranges: List(#(Int, Int))) -> List(#(Int, Int)) {
  ranges
  |> list.sort(tuple_of_int_comparator)
  |> merge_sorted_intervals([])
}

fn tuple_of_int_comparator(a: #(Int, Int), b: #(Int, Int)) -> order.Order {
  case int.compare(a.0, b.0) {
    order.Eq -> int.compare(a.1, b.1)
    ord -> ord
  }
}

fn merge_sorted_intervals(
  ranges: List(#(Int, Int)),
  merged: List(#(Int, Int)),
) -> List(#(Int, Int)) {
  case ranges, merged {
    [r, ..tail_r], [m, ..tail_m] if m.1 >= r.1 ->
      merge_sorted_intervals(tail_r, [m, ..tail_m])
    [r, ..tail_r], [m, ..tail_m] if m.1 >= r.0 ->
      merge_sorted_intervals(tail_r, [#(m.0, r.1), ..tail_m])
    [r, ..tail_r], m -> merge_sorted_intervals(tail_r, [r, ..m])
    [], m -> m
  }
}
