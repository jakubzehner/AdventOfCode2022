import gleam/set
import gleam/list
import gleam/int
import gleam/order
import sensor

pub fn count_not_beacon_positions(
  sensors: List(sensor.Sensor),
  at y: Int,
) -> Int {
  let #(ranges, beacons) =
    get_not_beacon_ranges_and_positions(sensors, y, [], [])
  let intervals = merge_intervals(ranges)
  calculate_not_beacon_positions(intervals, 0) - set.size(set.from_list(beacons))
}

fn get_not_beacon_ranges_and_positions(
  sensors: List(sensor.Sensor),
  y: Int,
  ranges: List(#(Int, Int)),
  beacons: List(Int),
) -> #(List(#(Int, Int)), List(Int)) {
  case sensors {
    [head, ..tail] ->
      get_not_beacon_ranges_and_positions(
        tail,
        y,
        list.append(sensor.coverage(head, at: y), ranges),
        list.append(sensor.get_beacon_x_if_at_y(head, y), beacons),
      )
    [] -> #(ranges, beacons)
  }
}

fn calculate_not_beacon_positions(ranges: List(#(Int, Int)), sum: Int) -> Int {
  case ranges {
    [#(a, b), ..tail] ->
      calculate_not_beacon_positions(tail, int.absolute_value(b - a) + sum + 1)
    [] -> sum
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
