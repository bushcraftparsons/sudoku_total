import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sudoku_total/sudoku_board.dart';

import 'icon_buttons.dart';
import 'number_buttons.dart';

class PlayRoute extends StatelessWidget {
  const PlayRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Total Sudoku'),
        ),
        body: Column(mainAxisSize: MainAxisSize.min, children: const [
          SudokuBoard(),
          SizedBox(height: 10),
          NumberButtons(),
          SizedBox(height: 10),
          IconButtons()
        ]));
  }
}