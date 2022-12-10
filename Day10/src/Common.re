let mapStringToValues = (line, last_val) => {
    switch(String.split_on_char(' ', line)) {
    | ["addx", n] => [last_val + int_of_string(n), last_val]
    | _ => [last_val]
    }
}

let read_input = (file_name) => {
    let input = open_in(file_name);
    let rec build = (values) => {
        switch(input_line(input)) {
        | line => build(mapStringToValues(line, List.hd(values)) @ values)
        | exception End_of_file => List.rev(List.tl(values))
        }
    }
    build([1]);
}