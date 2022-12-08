let get_list_of_dirs_sizes root = 
  let rec get_size_list file_system =
    match file_system with
    | File(_, _, size) -> ([], size)
    | Nil -> ([], 0)
    | Dir(_, _, childs) ->
      let childs_results = List.map get_size_list !childs in
      let calc (acc_list, acc_sum) (elem_list, elem_sum) =
        (((elem_list @ acc_list)), (elem_sum + acc_sum))
      in
      let (ls, sum) = List.fold_left calc ([], 0) childs_results in
      (sum::ls, sum)
  in get_size_list root
;;

let get_sum_of_dirs_sizes_smaller_than max_size root =
  let (list, sum) = get_list_of_dirs_sizes root in
  let pred elem = elem <= max_size in
  List.fold_left (+) 0 (List.filter pred list)
;;
