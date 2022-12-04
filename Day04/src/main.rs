use crate::common::read_input;
use crate::part1::calculate_full_containments;

mod common;
mod part1;

const FILE_NAME: &str = "inputs/test.txt";

fn main() {
    let input = read_input(FILE_NAME);
    println!("{}", calculate_full_containments(input));
}
