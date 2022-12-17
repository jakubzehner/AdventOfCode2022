import readInput from "./Common.js";
import mostPossiblePreassure from "./Part1.js";

const FILE_NAME = "./inputs/input.txt";
const TIME = 30;
const START_POSITION = "AA";

const adjatencyMap = readInput(FILE_NAME);
console.log(mostPossiblePreassure(adjatencyMap, TIME, START_POSITION));