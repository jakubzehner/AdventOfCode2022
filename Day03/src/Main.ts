const fileSync = require("fs");

import calculateSumOfPriorities from "./Part1";
import calculateSumOfBadgesPriorities from "./Part2";

const FILE_NAME = "inputs/input.txt";


const rucksacks = fileSync.readFileSync(FILE_NAME).toString().split("\n");

console.log(calculateSumOfPriorities(rucksacks));
console.log(calculateSumOfBadgesPriorities(rucksacks))