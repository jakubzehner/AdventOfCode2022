type operation = Noop | Addx(int);

let mapStringToOperation = (line) => {
    switch(String.split_on_char(' ', line)) {
    | ["addx", n] => Addx(int_of_string(n))
    | _ => Noop
    }
}

let read_input = (file_name) => {
    let input = open_in(file_name);
    let rec build = (operations) => {
        switch(input_line(input)) {
        | line => build([mapStringToOperation(line), ...operations])
        | exception End_of_file => List.rev(operations)
        }
    }
    build([]);
}