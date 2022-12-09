#use "Common.ml"
#use "Part1.ml"
#use "Part2.ml"

let file_name = "../inputs/input.txt";;
let size_limit = 100000;;
let total_disk_size = 70000000;;
let min_free_space = 30000000;;

let file_system_tree = build_file_system_from_input file_name;;
let size_list, size_sum = get_list_of_dirs_sizes file_system_tree;;

print_int (solution1 size_list size_limit);;
print_char '\n';;
print_int (get_smallest_directory_to_make_enough_free_space size_list size_sum min_free_space total_disk_size);;