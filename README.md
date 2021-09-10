# dijkstra

Find shortest path. 
A Dart port of [https://github.com/tcort/dijkstrajs](https://github.com/tcort/dijkstrajs) library.

## How to use

```dart


import 'package:dijkstra/dijkstra.dart';

main() {
  List<List> pairsList = [
    [0, 2],
    [3, 4],
    [0, 6],
    [5, 6],
    [2, 3],
    [0, 1],
    [0, 4],
    [0, 113],
    [113, 114],
    [111, 112]
  ];

  Map graph = {
    0: {2: 1, 6: 1, 1: 1, 4: 1, 113: 1},
    2: {0: 1, 3: 1},
    6: {0: 1, 5: 1},
    1: {0: 1},
    4: {0: 1, 3: 1},
    113: {0: 1, 114: 1},
    3: {2: 1, 4: 1},
    5: {6: 1},
    114: {113: 1},
    111: {112: 1},
    112: {111: 1}
  };
  int from = 114;
  int to = 5;

  var output1 = Dijkstra.findPathFromPairsList(pairsList, from, to);
  var output2 = Dijkstra.findPathFromGraph(graph, from, to);
  print("output1:");
  print(output1);
  print("output2:");
  print(output2);
  /// output1:
  /// [114, 113, 0, 6, 5]
  /// output2:
  /// [114, 113, 0, 6, 5]
}

```