type file_system =
  | Dir of file_system * string * file_system list ref
  | File of file_system * string * int
  | Nil
;;

let build_file_tree line parent =
  let get_sub_dir searched_dir =
    List.find (function (Dir(_, dir_name, _)) -> dir_name = searched_dir | _ -> false)
  in
  match String.split_on_char ' ' line, parent with
  | ["$"; "ls"], _ -> parent
  | ["$"; "cd"; "/"], _ -> parent
  | ["$"; "cd"; ".."], Dir(dir_parent, _, _) -> dir_parent
  | ["$"; "cd"; dir_name], Dir(_, _, subtree) -> get_sub_dir dir_name !subtree 
  | ["dir"; dir_name], Dir(_, _, subtree) -> subtree := Dir(parent, dir_name, ref [])::!subtree; parent
  | [file_size; file_name], Dir(_, _, subtree) -> subtree := File(parent, file_name, int_of_string file_size)::!subtree; parent
  | _, _ -> parent
;;

let build_file_tree_from_input input_file_name =
  let input = (open_in input_file_name) in
  let root = Dir(Nil, "/", ref []) in
  let rec build parent =
    match input_line input with
    | line -> build_file_tree line parent |> build
    | exception End_of_file -> close_in input; root
  in build root
;;

let get_size_list_and_sum root =
  let concat_and_sum (acc_ls, acc_sum) (elem_ls, elem_sum) =
    acc_ls @ elem_ls, acc_sum + elem_sum
  in  
  let rec get_size_list file_tree =
    match file_tree with
    | Nil -> [], 0
    | File(_, _, size) -> [], size
    | Dir(_, _, subtree) -> 
      !subtree
      |> List.map get_size_list
      |> List.fold_left concat_and_sum ([], 0)
      |> (fun (list, sum) -> sum::list, sum)
  in get_size_list root
;;