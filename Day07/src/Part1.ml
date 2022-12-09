let solution1 size_list max_size =
  size_list
  |> List.filter (fun x -> x <= max_size)
  |> List.fold_left (+) 0
;;