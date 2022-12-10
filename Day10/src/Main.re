let file_name = "inputs/test.txt"
let cycles = [20, 60, 100, 140, 180, 220];
let screen_width = 40;


let main = () => {
    let values = Common.read_input(file_name);
    print_int(Part1.signalStrengthsSum(values, cycles));
    print_string("\n");
    Part2.render_image(values, screen_width);
}