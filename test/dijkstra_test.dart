import 'package:flutter_test/flutter_test.dart';

import 'package:dijkstra/dijkstra.dart';

void main() {
  test('values', () {
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

    int from = 114;
    int to = 5;

    final calculator = Dijkstra.findPathFromPairsList(pairsList, from, to);

    List result = [114, 113, 0, 6, 5];
    expect(calculator, result);
  });
}
