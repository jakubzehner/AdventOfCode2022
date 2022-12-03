const fileSync = require("fs");

import calculateSumOfPriorities from "./Part1";

const FILE_NAME = "inputs/test.txt";


const rucksacks = fileSync.readFileSync(FILE_NAME).toString().split("\n");

console.log(calculateSumOfPriorities(rucksacks));