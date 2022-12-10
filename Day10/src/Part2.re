let generate_pixels = (values, screen_width) => {
    let rec generate = (values, cycle, pixels) => {
        switch(values) {
        | [value, ...t] when abs (cycle mod 40 - value) <= 1 => generate(t, cycle + 1, ["#", ...pixels])
        | [value, ...t] => generate(t, cycle + 1, [".", ...pixels])
        | [] => List.rev(pixels)
        }
    }
    generate(values, 0, [])
}

let render_image = (values, screen_width) => {
    let rec print_image = (pixels, width) => {
        switch(pixels, width) {
        | (pixels, 0) => print_string("\n"); print_image(pixels, screen_width)
        | ([h, ...t], width) => print_string(h); print_image(t, width - 1)
        | (_, _) => ()
        }
    }
    print_image(generate_pixels(values, screen_width), screen_width);
}