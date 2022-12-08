#use "Common.ml"
#use "Part1.ml"

let file_name = "../inputs/input.txt";;
let size_limit = 100000;;

let file_system_tree = build_file_system_from_input file_name;;
let (list, sum) = get_list_of_dirs_sizes file_system_tree;;

print_int (get_sum_of_dirs_sizes_smaller_than size_limit file_system_tree);;
