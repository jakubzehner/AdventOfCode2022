let solution2 size_list size_sum required_space disk_size =
  let unused_space = disk_size - size_sum in
  let needed_space = required_space - unused_space in
  size_list
  |> List.filter (fun x -> x >= needed_space)
  |> List.fold_left (fun acc x -> min acc x) size_sum
;;