import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sudoku_total/play_route.dart';

import 'logical_board.dart';

class ChooseRoute extends StatelessWidget {
  const ChooseRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Choose game"),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            //Create the new game
            LogicalBoard().newGame(Level.easy);
            // Navigate to the game play.
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const PlayRoute()),
            );
          },
          child: const Text('Easy'),
        ),
      ),
    );
  }
}