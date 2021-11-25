// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:sudoku_total/logical_board.dart';
import 'package:sudoku_total/sudoku_board.dart';

import 'number_buttons.dart';

void main() => runApp(const TotalSudokuApp());

final ThemeData sudokuThemeLight = ThemeData(
  primarySwatch: Colors.teal,
  primaryColor: Colors.teal[300],
  primaryColorDark: Colors.teal[900],
  primaryColorBrightness: Brightness.light,
);

class TotalSudokuApp extends StatelessWidget {
  const TotalSudokuApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Total Sudoku',
      theme: sudokuThemeLight,
      home: Scaffold(
          appBar: AppBar(
            title: const Text('Total Sudoku'),
          ),
          body: Column(mainAxisSize: MainAxisSize.min,children: [Expanded(child:
            const SudokuBoard()),
            Expanded(child:NumberButtons()),
          ])),
    );
  }
}


