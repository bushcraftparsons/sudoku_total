import 'package:flutter/cupertino.dart';

import 'logical_board.dart';

class SudokuBoard extends StatelessWidget {
  const SudokuBoard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(2.0),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          LogicalBoard.rowsWidgets[0],
          LogicalBoard.rowsWidgets[1],
          LogicalBoard.rowsWidgets[2],
          const SizedBox(height: 2),
          LogicalBoard.rowsWidgets[3],
          LogicalBoard.rowsWidgets[4],
          LogicalBoard.rowsWidgets[5],
          const SizedBox(height: 2),
          LogicalBoard.rowsWidgets[6],
          LogicalBoard.rowsWidgets[7],
          LogicalBoard.rowsWidgets[8],
        ]));
  }
}