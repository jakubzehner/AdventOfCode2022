let file_name = "inputs/input.txt"

let main = () => {
    let operations = Common.read_input(file_name);
    print_int(Part1.signalStrengthsSum(operations, [20, 60, 100, 140, 180, 220]));
}