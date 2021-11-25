import 'package:flutter/cupertino.dart';
import 'square.dart';
abstract class SquareCollection {
  final List<Square> squareList;
  const SquareCollection(this.squareList, {
    Key? key,
  });
}

class LogicalRow extends SquareCollection {
  LogicalRow(List<Square> squareList) : super(squareList);

}

class LogicalCol extends SquareCollection {
  LogicalCol(List<Square> squareList) : super(squareList);

}

class LogicalBox extends SquareCollection {
  LogicalBox(List<Square> squareList) : super(squareList);

}