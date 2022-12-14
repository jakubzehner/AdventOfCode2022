use std::fs::File;
use std::io::{BufRead, BufReader};

// dont care about incorrect input
pub fn read_input(file_path: &str) -> Vec<Vec<u32>> {
    let file = File::open(file_path).unwrap();
    let reader = BufReader::new(file);

    let mut result: Vec<Vec<u32>> = Vec::new();
    for line in reader.lines() {
        result.push(
            line.unwrap()
                .split(&['-', ','][..])
                .map(|x| x.parse::<u32>().unwrap())
                .collect(),
        );
    }
    result
}