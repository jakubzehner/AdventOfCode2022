import "Common.dart";

var FILE_NAME = "../inputs/input.txt";
var STARTING_POINT = "E";
var ENDING_POINT_PART1 = "S";
var ENDING_POINT_PART2 = "a";

void main() {
  var input = readInput(FILE_NAME);
  var graph = buildGraph(input);
  var graphValues = buildGraphValues(input);

  print(findShortestPath(graph, graphValues, STARTING_POINT, ENDING_POINT_PART1));
  print(findShortestPath(graph, graphValues, STARTING_POINT, ENDING_POINT_PART2));
}