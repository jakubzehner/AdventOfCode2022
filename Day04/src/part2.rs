pub fn calculate_containments(input: &&Vec<Vec<u32>>) -> usize {
    input.iter().filter(check_for_containment).count()
}

fn check_for_containment(pair: &&Vec<u32>) -> bool {
    pair[0] <= pair[3] && pair[1] >= pair[2]
}