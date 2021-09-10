library dijkstra;

class Dijkstra {
  static Map singleSourceShortestPaths(graph, s, end) {
    /// Predecessor map for each node that has been encountered.
    /// node ID => predecessor node ID
    var predecessors = {};

    /// Costs of shortest paths from s to all nodes encountered.
    /// node ID => cost
    var costs = {};
    costs[s] = 0;

    /// Costs of shortest paths from s to all nodes encountered; differs from
    /// `costs` in that it provides easy access to the node that currently has
    /// the known shortest path from s.
    var open = PriorityQueue();
    open.add(s, 0);

    var closest,
        u,
        costOfSToU,
        adjacentNodes,
        costOfE,
        costOfSToUPlusCostOfE,
        costOfSToV,
        firstVisit;
    while (!open.empty()) {
      /// In the nodes remaining in graph that have a known cost from s,
      /// find the node, u, that currently has the shortest path from s.
      closest = open.pop();
      u = closest?["value"];
      costOfSToU = closest["cost"];

      /// Get nodes adjacent to u...
      adjacentNodes = graph[u] ?? {};

      /// ...and explore the edges that connect u to those nodes, updating
      /// the cost of the shortest paths to any or all of those nodes as
      /// necessary. v is the node across the current edge from u.
      (adjacentNodes as Map).forEach((v, value) {
        if (adjacentNodes?[v] != null) {
          /// Get the cost of the edge running from u to v.
          costOfE = adjacentNodes[v];

          /// Cost of s to u plus the cost of u to v across e--this is *a*
          /// cost from s to v that may or may not be less than the current
          /// known cost to v.
          costOfSToUPlusCostOfE = costOfSToU + costOfE;

          /// If we haven't visited v yet OR if the current known cost from s to
          /// v is greater than the new cost we just found (cost of s to u plus
          /// cost of u to v across e), update v's cost in the cost list and
          /// update v's predecessor in the predecessor list (it's now u).
          costOfSToV = costs[v];
          firstVisit = costs[v] == null;
          if (firstVisit || costOfSToV > costOfSToUPlusCostOfE) {
            costs[v] = costOfSToUPlusCostOfE;
            open.add(v, costOfSToUPlusCostOfE);
            predecessors[v] = u;
          }
        }
      });
    }

    if (end != null && costs[end] == null) {
      print('Could not find a path');
    }

    return predecessors;
  }

  /// Extract shortest path from predecessor list
  static List extractShortestPathFromPredecessorList(predecessors, end) {
    var nodes = [];
    var u = end;
    while (u != null) {
      nodes.add(u);
      u = predecessors[u];
    }
    if (nodes.length == 1) return [];
    return nodes.reversed.toList();
  }

  /// Input: [[0, 2], [3, 4], [0, 6], [5, 6], [2, 3], [0, 1], [0, 4], [0, 113], [113, 114], [111, 112]]
  ///
  /// OutPut:  {0: {2: 1, 6: 1, 1: 1, 4: 1, 113: 1}, 2: {0: 1, 3: 1}, 6: {0: 1, 5: 1}, 1: {0: 1}, 4: {0: 1, 3: 1}, 113: {0: 1, 114: 1}, 3: {2: 1, 4: 1}, 5: {6: 1}, 114: {113: 1}, 111: {112: 1}, 112: {111: 1}}
  static Map pairsListToGraphMap(List<List> data) {
    Map layout = Map();
    Map graph = Map();
    Set ids = Set();
    data.forEach((element) {
      ids.addAll(element);
    });

    for (var id in ids) {
      layout[id] = data
          .where((e) => e.contains(id))
          .map((e) => e.firstWhere((x) => x != id))
          .toList();
    }

    layout.forEach((id, value) {
      if (graph[id] == null) graph[id] = {};
      layout[id].forEach((aid) {
        graph[id][aid] = 1;
        if (graph[aid] == null) graph[aid] = {};
        graph[aid][id] = 1;
      });
    });
    return graph;
  }

  /// Return the shortest path
  ///
  /// If have not the path, return empty list;
  ///
  /// List like:
  /// [[0, 2], [3, 4], [0, 6], [5, 6], [2, 3], [0, 1], [0, 4], [0, 113], [113, 114], [111, 112]]
  static List findPathFromPairsList(
      List<List> list, dynamic start, dynamic end) {
    var graph = pairsListToGraphMap(list);
    var predecessors = singleSourceShortestPaths(graph, start, end);

    return extractShortestPathFromPredecessorList(predecessors, end);
  }

  /// Return the shortest path
  ///
  /// If have not the path, return empty list;
  ///
  /// Graph like:
  /// {0: {2: 1, 6: 1, 1: 1, 4: 1, 113: 1}, 2: {0: 1, 3: 1}, 6: {0: 1, 5: 1}, 1: {0: 1}, 4: {0: 1, 3: 1}, 113: {0: 1, 114: 1}, 3: {2: 1, 4: 1}, 5: {6: 1}, 114: {113: 1}, 111: {112: 1}, 112: {111: 1}}
  static List findPathFromGraph(Map graph, dynamic start, dynamic end) {
    var predecessors = singleSourceShortestPaths(graph, start, end);

    return extractShortestPathFromPredecessorList(predecessors, end);
  }
}

class PriorityQueue {
  List queue = [];
  PriorityQueue();

  /// Add a new item to the queue and ensure the highest priority element
  /// is at the front of the queue.
  add(value, cost) {
    var item = {"value": value, "cost": cost};
    queue.add(item);
    queue.sort((a, b) {
      return a["cost"] - b["cost"];
    });
  }

  ///
  /// Return the highest priority element in the queue.
  pop() {
    return queue.removeAt(0);
  }

  bool empty() {
    return queue.length == 0;
  }
}
