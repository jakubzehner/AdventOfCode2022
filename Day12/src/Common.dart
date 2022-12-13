import 'dart:io';
import 'dart:collection';

List<List<String>> readInput(fileName) {
  List<List<String>> terrain = [];
  var lines = new File(fileName).readAsLinesSync();
  for (var line in lines) {
    terrain.add(line.trim().split('').toList());
  }
  return terrain;
}

List<String> buildGraphValues(List<List<String>> lines) {
  return lines.expand((v) => v).toList();
}

int getFirstRune(String chars){
  var rune = chars.runes.first;
  if (rune == "S".runes.first) rune = "a".runes.first;
  if (rune == "E".runes.first) rune = "z".runes.first;
  return rune;
}


bool isPassable(List<List<String>> lines, x, y, target_x, target_y) {
  if (target_x < 0) return false;
  if (target_y < 0) return false;
  if (target_x >= lines.length) return false;
  if (target_y >= lines[x].length) return false;

  var rune = getFirstRune(lines[x][y]);
  var target_rune = getFirstRune(lines[target_x][target_y]);
  return target_rune + 1 >= rune;
}

List<int> getPassableNeighbours(List<List<String>> lines, int x, int y) {
  List<int> result = [];
  var size_y = lines[x].length;
  if (isPassable(lines, x, y, x - 1, y)) result.add((x - 1) * size_y + y);
  if (isPassable(lines, x, y, x + 1, y)) result.add((x + 1) * size_y + y);
  if (isPassable(lines, x, y, x, y - 1)) result.add(x * size_y + y - 1);
  if (isPassable(lines, x, y, x, y + 1)) result.add(x * size_y + y + 1);

  return result;
}

List<List<int>> buildGraph(List<List<String>> lines) {
  List<List<int>> graph = [];
  for (var i = 0; i < lines.length; i++) {
    for (var j = 0; j < lines[i].length; j++) {
      graph.add(getPassableNeighbours(lines, i, j));
    }
  }
  return graph;
}

int findShortestPath(List<List<int>> graph, List<String> graphValues, String start, String destination) {
  var startNode = graphValues.indexOf(start);
  var distance = List.filled(graph.length, -1);
  var visited = List.filled(graph.length, false);
  var queue = new Queue<int>();

  visited[startNode] = true;
  distance[startNode] = 0;
  queue.add(startNode);

  while (queue.isNotEmpty) {
    var currNode = queue.removeFirst();
    for (var nextNode in graph[currNode]) {
      if (visited[nextNode]) continue;
      visited[nextNode] = true;
      distance[nextNode] = distance[currNode] + 1;
      queue.add(nextNode);

      if (graphValues[nextNode] == destination) {
        return distance[nextNode];
      }
    }
  }
  return -1;
}
