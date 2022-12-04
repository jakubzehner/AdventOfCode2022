use crate::common::read_input;
use crate::part1::calculate_full_containments;
use crate::part2::calculate_containments;

mod common;
mod part1;
mod part2;

const FILE_NAME: &str = "inputs/test.txt";

fn main() {
    let input = read_input(FILE_NAME);
    println!("{}", calculate_full_containments(&&input));
    println!("{}", calculate_containments(&&input));
}
