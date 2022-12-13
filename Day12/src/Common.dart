import 'dart:io';

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

bool isPassable(List<List<String>> lines, x, y, target_x, target_y) {
  if (target_x < 0)
    return false;
  if (target_y < 0)
    return false;
  if (target_x >= lines.length)
    return false;
  if (target_y >= lines[x].length)
    return false;
  
  var rune = lines[x][y].runes;
  var target_rune = lines[target_x][target_y].runes;
  if (rune.first == "S".runes.first)
    rune = "a".runes;
  if (rune.first == "E".runes.first)
    rune = "z".runes;
  if (target_rune.first == "S".runes.first)
    target_rune = "a".runes;
  if (target_rune.first == "E".runes.first)
    target_rune = "z".runes;
  
  return target_rune.first + 1 >= rune.first;  
}

List<int> getPassableNeighbours(List<List<String>> lines, int x, int y) {
  List<int> result = [];
  var size_y = lines[x].length;
  if (isPassable(lines, x, y, x - 1 , y))
    result.add((x - 1) * size_y + y);
  if (isPassable(lines, x, y, x + 1 , y))
    result.add((x + 1) * size_y + y);
  if (isPassable(lines, x, y, x , y - 1))
    result.add(x * size_y + y - 1);
  if (isPassable(lines, x, y, x, y + 1))
    result.add(x * size_y + y + 1);

  return result;
}

List<List<int>> buildGraph(List<List<String>> lines) {
  List<List<int>> graph = [];
  for(var i = 0; i < lines.length; i++) {
    for(var j = 0; j < lines[i].length; j++) {
      graph.add(getPassableNeighbours(lines, i, j));
    }
  }
  return graph;
}
