pub fn calculate_full_containments(input: Vec<Vec<u32>>) -> usize {
    input.iter().filter(check_for_full_containment).count()
}

fn check_for_full_containment(pair: &&Vec<u32>) -> bool {
    if pair[0] > pair[2] {
        pair[1] <= pair[3]
    } else if pair[0] < pair[2] {
        pair[1] >= pair[3]
    } else {
        true
    }
}
