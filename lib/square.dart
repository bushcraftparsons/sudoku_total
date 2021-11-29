import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'logical_board.dart';

class Square extends StatelessWidget {
  final Color _mainColour;
  final Color _selectedColour;
  final int _squareIndex;
  final int? _mainNumber;
  final int? _answer;
  final bool _showEdit1;
  final bool _showEdit2;
  final bool _showEdit3;
  final bool _showEdit4;
  final bool _showEdit5;
  final bool _showEdit6;
  final bool _showEdit7;
  final bool _showEdit8;
  final bool _showEdit9;
  final bool _selected;
  final bool _selectedCollection;
  const Square({
    Key? key,
    required int squareIndex,
    required int? mainNumber,
    required int? answer,
    required bool showEdit1,
    required bool showEdit2,
    required bool showEdit3,
    required bool showEdit4,
    required bool showEdit5,
    required bool showEdit6,
    required bool showEdit7,
    required bool showEdit8,
    required bool showEdit9,
    required bool selected,
    required bool selectedCollection,
    required Color mainColour,
    required Color selectedColour,
  })  : _squareIndex = squareIndex,
        _mainNumber = mainNumber,
        _answer = answer,
        _showEdit1 = showEdit1,
        _showEdit2 = showEdit2,
        _showEdit3 = showEdit3,
        _showEdit4 = showEdit4,
        _showEdit5 = showEdit5,
        _showEdit6 = showEdit6,
        _showEdit7 = showEdit7,
        _showEdit8 = showEdit8,
        _showEdit9 = showEdit9,
        _selected = selected,
        _selectedCollection = selectedCollection,
        _mainColour = mainColour,
  _selectedColour = selectedColour,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
        child: InkWell(
            onTap: () => LogicalBoard().setSelectedSquare(_squareIndex),
            child: Container(
              padding: const EdgeInsets.all(2.0),
              color: _selected
                  ? Theme.of(context).errorColor
                  : Theme.of(context).primaryColorDark,
              width: 52.0,
              height: 52.0,
              child: Container(
                  padding: _mainNumber == null
                      ? const EdgeInsets.fromLTRB(2.0, 8.0, 2.0, 2.0)
                      : const EdgeInsets.all(0.0),
                  color: _selectedCollection
                      ? _selectedColour
                      : _mainColour,
                  width: 46.0,
                  height: 46.0,
                  child: _mainNumber != null
                      ? Center(
                          child: Text(
                          _mainNumber.toString(),
                          style: Theme.of(context).textTheme.headline4,
                        ))
                      : Column(mainAxisSize: MainAxisSize.min, children: [
                          Flexible(
                              child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                Flexible(
                                    child: Text(
                                  _showEdit1 ? "1" : "",
                                  style: Theme.of(context).textTheme.bodyText2,
                                )),
                                Flexible(
                                    child: Text(
                                  _showEdit2 ? "2" : "",
                                  style: Theme.of(context).textTheme.bodyText2,
                                )),
                                Flexible(
                                    child: Text(
                                  _showEdit3 ? "3" : "",
                                  style: Theme.of(context).textTheme.bodyText2,
                                ))
                              ])),
                          Flexible(
                              child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                Flexible(
                                    child: Text(
                                  _showEdit4 ? "4" : "",
                                  style: Theme.of(context).textTheme.bodyText2,
                                )),
                                Flexible(
                                    child: Text(
                                  _showEdit5 ? "5" : "",
                                  style: Theme.of(context).textTheme.bodyText2,
                                )),
                                Flexible(
                                    child: Text(
                                  _showEdit6 ? "6" : "",
                                  style: Theme.of(context).textTheme.bodyText2,
                                ))
                              ])),
                          Flexible(
                              child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                Flexible(
                                    child: Text(
                                  _showEdit7 ? "7" : "",
                                  style: Theme.of(context).textTheme.bodyText2,
                                )),
                                Flexible(
                                    child: Text(
                                  _showEdit8 ? "8" : "",
                                  style: Theme.of(context).textTheme.bodyText2,
                                )),
                                Flexible(
                                    child: Text(
                                  _showEdit9 ? "9" : "",
                                  style: Theme.of(context).textTheme.bodyText2,
                                ))
                              ]))
                        ])),
            )));
  }
}
