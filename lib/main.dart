// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sudoku_total/choose_route.dart';
import 'package:sudoku_total/play_route.dart';
import 'package:sudoku_total/state_persistor.dart';
import 'logical_board.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  readState().then((state) {
    print("Have just read the state " + jsonEncode(state));
    if (state.isNotEmpty) {
      LogicalBoard().setState(state);
    }
    runApp(TotalSudokuApp(state));
  });
}

final ThemeData sudokuThemeLight = ThemeData(
  primarySwatch: Colors.teal,
  primaryColor: Colors.teal[300],
  primaryColorDark: Colors.teal[900],
  primaryColorBrightness: Brightness.light,
);

class TotalSudokuApp extends StatelessWidget {
  final Map<String, dynamic> state;
  const TotalSudokuApp(
    this.state, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Total Sudoku',
      theme: sudokuThemeLight.copyWith(
        colorScheme: sudokuThemeLight.colorScheme.copyWith(
            secondary: Colors.amber[300], background: Colors.amber[50]),
      ),
      home: state.isEmpty ? const ChooseRoute() : const PlayRoute(),
    );
  }
}
