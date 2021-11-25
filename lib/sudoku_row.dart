import 'package:flutter/cupertino.dart';
import 'square.dart';

class SudokuRow extends StatefulWidget {
  final List<Square> squareList;
  final int rowIndex;
  const SudokuRow(this.squareList, this.rowIndex, {
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SudokuRowState();
}

class _SudokuRowState extends State<SudokuRow> {
  @override
  Widget build(BuildContext context) {
    return Flexible(child:Row(mainAxisSize: MainAxisSize.min, children: [
      widget.squareList.elementAt(0),
      widget.squareList.elementAt(1),
      widget.squareList.elementAt(2),
      const SizedBox(width: 2),
      widget.squareList.elementAt(3),
      widget.squareList.elementAt(4),
      widget.squareList.elementAt(5),
      const SizedBox(width: 2),
      widget.squareList.elementAt(6),
      widget.squareList.elementAt(7),
      widget.squareList.elementAt(8)
    ]));
  }
}