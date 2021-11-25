import 'package:flutter/cupertino.dart';
import 'package:sudoku_total/square_model.dart';

abstract class SquareCollection {
  final List<SquareModel> squareList;
  const SquareCollection(this.squareList, {
    Key? key,
  });
}

class LogicalRow extends SquareCollection {
  LogicalRow(List<SquareModel> squareList) : super(squareList);

}

class LogicalCol extends SquareCollection {
  LogicalCol(List<SquareModel> squareList) : super(squareList);

}

class LogicalBox extends SquareCollection {
  LogicalBox(List<SquareModel> squareList) : super(squareList);

}