import translateCharToPriority from "./Common"

function calculateSumOfPriorities(rucksacks: string[]): number {
    return rucksacks.reduce(calculatePriorities, 0);
}

function calculatePriorities(sumOfPriorities: number, rucksack: string): number {
    rucksack = rucksack.trim();
    const half = rucksack.length / 2;

    const uniqueItems = new Set<string>();
    Array.from(rucksack.slice(0, half))
        .forEach(char => uniqueItems.add(char));

    sumOfPriorities += translateCharToPriority(Array.from(rucksack.slice(half))
        .find(char => uniqueItems.has(char))!);
        
    return sumOfPriorities;
}

export default calculateSumOfPriorities;