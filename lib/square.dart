import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sudoku_total/logical_board.dart';

class Square extends StatefulWidget {
  final int squareIndex;
  final int boxIndex;
  final int rowIndex;
  final int colIndex;
  const Square(
    this.squareIndex,
    this.boxIndex,
    this.rowIndex,
    this.colIndex, {
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SquareState();
}

class _SquareState extends State<Square> {
  int _mainNumber = 0;
  bool showEdit1 = false;
  bool showEdit2 = false;
  bool showEdit3 = false;
  bool showEdit4 = false;
  bool showEdit5 = false;
  bool showEdit6 = false;
  bool showEdit7 = false;
  bool showEdit8 = false;
  bool showEdit9 = false;
  bool _selected = false;
  bool _selectedCollection = false;

  @override
  Widget build(BuildContext context) {
    LogicalBoard.numberButtonNotifier.addListener(() {
      if(LogicalBoard.selectedSquare?.squareIndex == widget.squareIndex){
        setState(() {
          _mainNumber = LogicalBoard.numberLastClicked;
        });
      }
    });
    LogicalBoard.selectionNotifier.addListener(() {
      setState(() {
        _selected =
            LogicalBoard.selectedSquare?.squareIndex == widget.squareIndex;
        _selectedCollection =
            LogicalBoard.selectedSquare?.squareIndex == widget.squareIndex ||
                LogicalBoard.selectedSquare?.rowIndex == widget.rowIndex ||
                LogicalBoard.selectedSquare?.colIndex == widget.colIndex ||
                LogicalBoard.selectedSquare?.boxIndex == widget.boxIndex;
      });
    });
    return Material(
        child: InkWell(
            onTap: () => LogicalBoard.selectionNotifier
                .setSelectedSquare(widget.squareIndex),
            child: Container(
              padding: const EdgeInsets.all(2.0),
              color: _selected
                  ? Theme.of(context).errorColor
                  : Theme.of(context).primaryColorDark,
              width: 52.0,
              height: 52.0,
              child: Container(
                  padding: _mainNumber == 0
                      ? const EdgeInsets.fromLTRB(2.0, 8.0, 2.0, 2.0)
                      : const EdgeInsets.all(0.0),
                  color: _selectedCollection
                      ? Theme.of(context).backgroundColor
                      : Theme.of(context).primaryColor,
                  width: 48.0,
                  height: 48.0,
                  child: _mainNumber != 0
                      ? Center(
                          child: Text(
                          _mainNumber.toString(),
                          style: Theme.of(context).textTheme.headline3,
                        ))
                      : Column(mainAxisSize: MainAxisSize.min, children: [
                          Flexible(
                              child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                Flexible(
                                    child: Text(
                                  showEdit1 ? "1" : "",
                                  style: Theme.of(context).textTheme.bodyText2,
                                )),
                                Flexible(
                                    child: Text(
                                  showEdit2 ? "2" : "",
                                  style: Theme.of(context).textTheme.bodyText2,
                                )),
                                Flexible(
                                    child: Text(
                                  showEdit3 ? "3" : "",
                                  style: Theme.of(context).textTheme.bodyText2,
                                ))
                              ])),
                          Flexible(
                              child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                Flexible(
                                    child: Text(
                                  showEdit4 ? "4" : "",
                                  style: Theme.of(context).textTheme.bodyText2,
                                )),
                                Flexible(
                                    child: Text(
                                  showEdit5 ? "5" : "",
                                  style: Theme.of(context).textTheme.bodyText2,
                                )),
                                Flexible(
                                    child: Text(
                                  showEdit6 ? "6" : "",
                                  style: Theme.of(context).textTheme.bodyText2,
                                ))
                              ])),
                          Flexible(
                              child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                Flexible(
                                    child: Text(
                                  showEdit7 ? "7" : "",
                                  style: Theme.of(context).textTheme.bodyText2,
                                )),
                                Flexible(
                                    child: Text(
                                  showEdit8 ? "8" : "",
                                  style: Theme.of(context).textTheme.bodyText2,
                                )),
                                Flexible(
                                    child: Text(
                                  showEdit9 ? "9" : "",
                                  style: Theme.of(context).textTheme.bodyText2,
                                ))
                              ]))
                        ])),
            )));
  }
}
