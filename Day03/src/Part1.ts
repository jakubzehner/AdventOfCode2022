import translateCharToPriority from "./Common"

function calculateSumOfPriorities(rucksacks: string[]): number {
    let sumOfPriorities = 0;

    for (let rucksack of rucksacks) {
        rucksack = rucksack.trim();

        const half = rucksack.length / 2;
        const firstCompartment = rucksack.slice(0, half);
        const secondCompartment = rucksack.slice(half);

        const uniqueItems = new Set<string>();
        for (const char of firstCompartment) {
            uniqueItems.add(char);
        }

        for (const char of secondCompartment) {
            if (uniqueItems.has(char)) {
                sumOfPriorities += translateCharToPriority(char);
                break;
            }
        }
    }

    return sumOfPriorities;
}

export default calculateSumOfPriorities;