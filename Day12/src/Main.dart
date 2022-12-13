import "Common.dart";
import "Part1.dart";

var FILE_NAME = "../inputs/input.txt";
void main() {
  var input = readInput(FILE_NAME);
  var graph = buildGraph(input);
  var graphValues = buildGraphValues(input);

  print(findShortestPath(graph, graphValues, "E", "S"));
}