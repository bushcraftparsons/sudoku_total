import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:sudoku_total/square.dart';
import 'package:sudoku_total/square_collection.dart';

class SquareModel extends ChangeNotifier {
  final int squareIndex;
  final int rowIndex;
  final int colIndex;
  final int boxIndex;
  LogicalBox? box;
  LogicalRow? row;
  LogicalCol? col;

  SquareModel(this.squareIndex, this.rowIndex, this.colIndex, this.boxIndex);

  int? _mainNumber;
  int? _answer;
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

  setEditNumber(value) {
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
    notifyListeners();
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

  set mainNumber(int? value) {
    _mainNumber = value;
    notifyListeners();
  }

  int? get answer => _answer;

  set answer(int? value) {
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

  getSquare() => ChangeNotifierProvider(
      create: (context) => this,
      child: Consumer<SquareModel>(
        builder: (context, square, child) => Square(
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
        ),
      ));
}
