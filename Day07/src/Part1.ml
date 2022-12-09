let get_sum_of_dirs_sizes_smaller_than max_size root =
  let (list, sum) = get_list_of_dirs_sizes root in
  let pred elem = elem <= max_size in
  List.fold_left (+) 0 (List.filter pred list)
;;
