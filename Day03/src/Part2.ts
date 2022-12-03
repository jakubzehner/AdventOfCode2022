import translateCharToPriority from "./Common"

function calculateSumOfBadgesPriorities(rucksacks: string[]): number {
    let sumOfBadgesPriorities = 0;

    for (let i = 0; i < rucksacks.length; i += 3) {
        const firstRucksack = rucksacks[i].trim();
        const secondRucksack = rucksacks[i + 1].trim();
        const thirdRucksack = rucksacks[i + 2].trim();

        const uniqueItems = new Set<string>();
        for (const char of firstRucksack) {
            uniqueItems.add(char);
        }

        const repeatedItems = new Set<string>();
        for (const char of secondRucksack) {
            if (uniqueItems.has(char)) {
                repeatedItems.add(char);
            }
        }
        
        for (const char of thirdRucksack) {
            if (repeatedItems.has(char)) {
                sumOfBadgesPriorities += translateCharToPriority(char);
                break;
            }
        }
    }

    return sumOfBadgesPriorities;
}

export default calculateSumOfBadgesPriorities;