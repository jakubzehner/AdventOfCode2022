import readInput from "./Common.js";
import mostPossiblePreassure from "./Part1.js";

const FILE_NAME = "./inputs/test.txt";
const TIME = 30;

const adjatencyMap = readInput(FILE_NAME);
console.log(mostPossiblePreassure(adjatencyMap, TIME));