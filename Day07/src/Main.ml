#use "Common.ml"
#use "Part1.ml"
#use "Part2.ml"

let file_name = "../inputs/input.txt";;
let max_size = 100000;;
let disk_size = 70000000;;
let required_space = 30000000;;

let file_tree = build_file_system_from_input file_name;;
let size_list, size_sum = get_size_list_and_sum file_tree;;

print_int @@ solution1 size_list max_size;;
print_char '\n';;
print_int @@ solution2 size_list size_sum required_space disk_size;;