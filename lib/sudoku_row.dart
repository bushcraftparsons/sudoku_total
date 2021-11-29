import 'package:flutter/cupertino.dart';
import 'package:sudoku_total/square_model.dart';


class SudokuRow extends StatefulWidget {
  final List<SquareModel> squareList;
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
    return Row(mainAxisSize: MainAxisSize.min, children: [
      Expanded(child: widget.squareList.elementAt(0).getSquare()),
    Expanded(child:widget.squareList.elementAt(1).getSquare()),
    Expanded(child:widget.squareList.elementAt(2).getSquare()),
    const SizedBox(width: 2),
    Expanded(child:widget.squareList.elementAt(3).getSquare()),
    Expanded(child:widget.squareList.elementAt(4).getSquare()),
    Expanded(child:widget.squareList.elementAt(5).getSquare()),
    const SizedBox(width: 2),
    Expanded(child: widget.squareList.elementAt(6).getSquare()),
    Expanded(child: widget.squareList.elementAt(7).getSquare()),
    Expanded(child: widget.squareList.elementAt(8).getSquare())
    ]);
  }
}