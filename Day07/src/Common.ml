type file_system =
  | Dir of file_system * string * file_system list ref
  | File of file_system * string * int
  | Nil
;;

let print_file_system file_system = 
  let rec p_f_s offset curr_sys =
    match curr_sys with
    | File (_, s, i) -> print_string offset; print_string s; print_string "\n"
    | Dir (_, s, ls) -> print_string offset; print_string s; print_string "\n"; List.iter (p_f_s ("  " ^ offset)) !ls
    | Nil -> ()
  in p_f_s "" file_system
;;

let build_file_system input_line parent =
  let find_child childs path =
    let rec check_child childs =
        match childs with
        | Dir(_, _path, _) as next :: _ when _path = path -> next
        | _::t -> check_child t
        | [] -> Nil
    in check_child childs
  in
  match String.split_on_char ' ' input_line with
  | ["$"; "ls"] -> parent;
  | ["$"; "cd"; "/"] -> parent
  | ["$"; "cd"; ".."] -> (
    match parent with
    | Dir(p, _, _) -> p
    | _ -> parent
  )
  | ["$"; "cd"; path] -> (
    match parent with
    | Dir(_, _, childs) -> find_child !childs path
    | _ -> parent
  )
  | ["dir"; dir_name] -> (
    match parent with
    | Dir(_, _, childs) -> childs := (Dir(parent, dir_name, ref [])::!childs); parent
    | _ -> parent
  )
  | [size; file_name] -> (
    match parent with
    | Dir(_, _, childs) -> childs := (File(parent, file_name, int_of_string size)::!childs); parent
    | _ -> parent
  )
  | other -> parent
;;

let build_file_system_from_input input_file_name =
  let input = (open_in input_file_name) in
  let root = Dir(Nil, "/", ref []) in
  let rec build parent =
    match input_line input with
    | line -> build (build_file_system line parent)
    | exception End_of_file -> close_in input; root
  in build root
;;
