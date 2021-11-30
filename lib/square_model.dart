import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sudoku_total/logical_board.dart';
import 'package:sudoku_total/square.dart';
import 'package:sudoku_total/square_collection.dart';

int compareSquares(SquareModel a, SquareModel b) =>
    a.squareIndex.compareTo(b.squareIndex);
Comparator<SquareModel> squareComparator = compareSquares;

class SquareModel extends ChangeNotifier {
  final int squareIndex;
  final int rowIndex;
  final int colIndex;
  final int boxIndex;
  late LogicalBox box;
  late LogicalRow row;
  late LogicalCol col;

  SquareModel(this.squareIndex, this.rowIndex, this.colIndex, this.boxIndex);

  int? _mainNumber;
  late int _answer = 0;
  bool _showEdit1 = false;
  bool _showEdit2 = false;
  bool _showEdit3 = false;
  bool _showEdit4 = false;
  bool _showEdit5 = false;
  bool _showEdit6 = false;
  bool _showEdit7 = false;
  bool _showEdit8 = false;
  bool _showEdit9 = false;
  bool _selected = false;
  bool _selectedCollection = false;

  /// true if shown at the start of the game
  bool _shown = false;

  /// true if square is calculable from the show solutions
  bool _calculable = false;

  /// Solutions which are still possible for this square given the game board.
  /// Used when calculating which squares to show.
  Set<int> _possibleSolutions = {1, 2, 3, 4, 5, 6, 7, 8, 9};

  void penChanged() {
    notifyListeners();
  }

  set editNumber(value) {
    if (_mainNumber != _answer) {
      _mainNumber = null;
    }
    switch (value) {
      case 1:
        _showEdit1 = !_showEdit1;
        break;
      case 2:
        _showEdit2 = !_showEdit2;
        break;
      case 3:
        _showEdit3 = !_showEdit3;
        break;
      case 4:
        _showEdit4 = !_showEdit4;
        break;
      case 5:
        _showEdit5 = !_showEdit5;
        break;
      case 6:
        _showEdit6 = !_showEdit6;
        break;
      case 7:
        _showEdit7 = !_showEdit7;
        break;
      case 8:
        _showEdit8 = !_showEdit8;
        break;
      case 9:
        _showEdit9 = !_showEdit9;
    }
  }

  List<int> getEditNumbers() {
    List<int> editNumbers = [];
    if (_showEdit1) {
      editNumbers.add(1);
    }
    if (_showEdit2) {
      editNumbers.add(2);
    }
    if (_showEdit3) {
      editNumbers.add(3);
    }
    if (_showEdit4) {
      editNumbers.add(4);
    }
    if (_showEdit5) {
      editNumbers.add(5);
    }
    if (_showEdit6) {
      editNumbers.add(6);
    }
    if (_showEdit7) {
      editNumbers.add(7);
    }
    if (_showEdit8) {
      editNumbers.add(8);
    }
    if (_showEdit9) {
      editNumbers.add(9);
    }
    return editNumbers;
  }

  int? get mainNumber => _mainNumber;

  set number(int? value) {
    if (_mainNumber != _answer && !_shown) {
      //Square not editable when it is shown as a starting square, nor
      //after the correct answer has been added
      if (LogicalBoard().pen) {
        //Setting the main number
        if (_mainNumber == value) {
          _mainNumber = null;
        } else {
          _mainNumber = value;
        }
      } else {
        //Setting the edit numbers
        if (_mainNumber != null) {
          _mainNumber = null;
        }
        editNumber = value;
      }
      notifyListeners();
    }
  }

  get possibleSolutions => _possibleSolutions;

  int? getCalculableAnswer() {
    if (_shown || isCalculable()) {
      return _answer;
    } else {
      return null;
    }
  }

  bool hasHiddenSingle() {
    bool hasHiddenSingle = (row.isLastSolution(_answer) ||
        col.isLastSolution(_answer) ||
        box.isLastSolution(_answer));
    if (hasHiddenSingle) {
      calculable = true;
    }
    return hasHiddenSingle;
  }

  bool get shown => _shown;

  bool isCalculable() {
    return _calculable || hasHiddenSingle();
  }

  set calculable(bool calculable) => _calculable = calculable;

  int get answer => _answer;

  set answer(int value) {
    _answer = value;
    notifyListeners();
  }

  bool get selected => _selected;

  set selected(bool value) {
    _selected = value;
    notifyListeners();
  }

  bool get selectedCollection => _selectedCollection;

  set selectedCollection(bool value) {
    _selectedCollection = value;
    notifyListeners();
  }

  void removePossibleSolution(int possibleSolution) {
    _possibleSolutions.remove(possibleSolution);
    if (_possibleSolutions.length == 1) {
      _calculable = true;
    }
  }

  void showAnswer() {
    if (_answer != 0) {
      _possibleSolutions.clear();
      _possibleSolutions.add(_answer);
      //Remove the answer from possible solutions in other squares in
      //the row, col and box
      for (SquareModel sq in col.getRestOfSet(this)) {
        sq.removePossibleSolution(_answer);
      }
      for (SquareModel sq in row.getRestOfSet(this)) {
        sq.removePossibleSolution(_answer);
      }
      for (SquareModel sq in box.getRestOfSet(this)) {
        sq.removePossibleSolution(_answer);
      }
      _mainNumber = _answer;
      _shown = true;
      _calculable = true;
      notifyListeners();
    }
  }

  void erase() {
    if (_mainNumber != _answer || _answer == 0) {
      _mainNumber = null;
      _showEdit1 = false;
      _showEdit2 = false;
      _showEdit3 = false;
      _showEdit4 = false;
      _showEdit5 = false;
      _showEdit6 = false;
      _showEdit7 = false;
      _showEdit8 = false;
      _showEdit9 = false;
      notifyListeners();
    }
  }

  /// Resets the square ready for a new game
  void reset() {
    _answer = 0;
    erase();
    _shown = false;
    _calculable = false;
    _possibleSolutions = {1, 2, 3, 4, 5, 6, 7, 8, 9};
    notifyListeners();
  }

  Set<int> possibleAnswers() {
    //Create the set
    Set<int> possibleAnswers = {1, 2, 3, 4, 5, 6, 7, 8, 9};
    //Remove the ones already in the row, col or box
    row.removeDuplicates(possibleAnswers);
    col.removeDuplicates(possibleAnswers);
    box.removeDuplicates(possibleAnswers);
    return possibleAnswers;
  }

  Map<String, Object> getSquareState() {
    return {
      'squareIndex': squareIndex,
      '_mainNumber': _mainNumber.toString(),
      '_answer': _answer,
      '_showEdit1': _showEdit1,
      '_showEdit2': _showEdit2,
      '_showEdit3': _showEdit3,
      '_showEdit4': _showEdit4,
      '_showEdit5': _showEdit5,
      '_showEdit6': _showEdit6,
      '_showEdit7': _showEdit7,
      '_showEdit8': _showEdit8,
      '_showEdit9': _showEdit9,
      '_shown': _shown,
      '_calculable': _calculable,
      '_possibleSolutions': _possibleSolutions.toList(),
    };
  }

  void setSquareState(Map<String, dynamic> state){
    print("State for one square " + json.encode(state));
    if(state['_mainNumber'] == 'null'){
      _mainNumber=null;
    }else{
      _mainNumber=int.parse(state['_mainNumber']);
    }
    _answer = state['_answer'] as int;
    _showEdit1 = state['_showEdit1'] as bool;
    _showEdit2 = state['_showEdit2'] as bool;
    _showEdit3 = state['_showEdit3'] as bool;
    _showEdit4 = state['_showEdit4'] as bool;
    _showEdit5 = state['_showEdit5'] as bool;
    _showEdit6 = state['_showEdit6'] as bool;
    _showEdit7 = state['_showEdit7'] as bool;
    _showEdit8 = state['_showEdit8'] as bool;
    _showEdit9 = state['_showEdit9'] as bool;
    _shown = state['_shown'] as bool;
    _calculable = state['_calculable'] as bool;
    _possibleSolutions = ((state['_possibleSolutions'].cast<int>())).toSet();
  }

  getSquare() {
    return ChangeNotifierProvider(
        create: (context) => this,
        child: Consumer<SquareModel>(builder: (context, square, child) {
          return Square(
            shown: _shown,
            selectedColour: LogicalBoard().pen
                ? Theme.of(context).backgroundColor
                : Theme.of(context).colorScheme.background,
            mainColour: LogicalBoard().pen
                ? Theme.of(context).primaryColor
                : Theme.of(context).colorScheme.secondary,
            squareIndex: squareIndex,
            mainNumber: _mainNumber,
            answer: _answer,
            selected: _selected,
            selectedCollection: _selectedCollection,
            showEdit1: _showEdit1,
            showEdit2: _showEdit2,
            showEdit3: _showEdit3,
            showEdit4: _showEdit4,
            showEdit5: _showEdit5,
            showEdit6: _showEdit6,
            showEdit7: _showEdit7,
            showEdit8: _showEdit8,
            showEdit9: _showEdit9,
          );
        }));
  }
}
