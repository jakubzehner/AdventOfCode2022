import translateCharToPriority from "./Common"

function calculateSumOfBadgesPriorities(rucksacks: string[]): number {
    let sumOfBadgesPriorities = 0;

    for (let i = 0; i < rucksacks.length; i += 3) {
        const uniqueItems = new Set<string>();
        Array.from(rucksacks[i].trim())
            .forEach(char => uniqueItems.add(char));

        const repeatedItems = new Set<string>();
        Array.from(rucksacks[i + 1].trim())
            .filter(char => uniqueItems.has(char))
            .forEach(char => repeatedItems.add(char));

        sumOfBadgesPriorities += translateCharToPriority(Array.from(rucksacks[i + 2].trim())
            .find(char => repeatedItems.has(char))!);
    }

    return sumOfBadgesPriorities;
}

export default calculateSumOfBadgesPriorities;