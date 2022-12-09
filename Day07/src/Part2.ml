let get_smallest_directory_to_make_enough_free_space list sum min_free_space total_disk_size =
  let space_to_free = min_free_space - total_disk_size + sum in
  let rec get_smallest_dir_size list smallest =
    match list with
    | h::t -> if h >= space_to_free && h < smallest then
        get_smallest_dir_size t h
      else
        get_smallest_dir_size t smallest
    | [] -> smallest
  in get_smallest_dir_size list sum
;;