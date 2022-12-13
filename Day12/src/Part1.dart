import 'dart:collection';

// XD
var MAX_INT = 10000;

int findShortestPath(List<List<int>> graph, List<String> graphValues, String start, String destination) {
  return bfs(graph, graphValues.indexOf(start), graphValues.indexOf(destination));
}

int bfs(List<List<int>> graph, int start, int end) {
  var dist = List.filled(graph.length, MAX_INT);
  var visited = List.filled(graph.length, false);
  var queue = new Queue<int>();

  visited[start] = true;
  dist[start] = 0;
  queue.add(start);

  while(queue.isNotEmpty) {
    var node = queue.removeFirst();
    for (var connection in graph[node]) {
      if (visited[connection])
        continue;
      visited[connection] = true;
      dist[connection] = dist[node] + 1;
      queue.add(connection);

      if(connection == end){
        return dist[connection];
      }
    }
  }
  return -1;
}