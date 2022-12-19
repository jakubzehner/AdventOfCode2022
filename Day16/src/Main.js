import {readInput} from "./Common.js";
import mostPossiblePreassure from "./Part1.js";
import mostPossiblePreassureWithElephant from "./Part2.js";


const FILE_NAME = "./inputs/input.txt";
const TIME_PART1 = 30;
const TIME_PART2 = 26;
const START_POSITION = "AA";

const input = readInput(FILE_NAME);
const flows = input[0];
const distances = input[1];

console.log(mostPossiblePreassure(flows, distances, TIME_PART1, START_POSITION));
console.log(mostPossiblePreassureWithElephant(flows, distances, TIME_PART2, START_POSITION));
