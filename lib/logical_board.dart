import 'package:flutter/cupertino.dart';
import 'package:sudoku_total/square.dart';
import 'package:sudoku_total/square_model.dart';
import 'package:sudoku_total/sudoku_row.dart';
import 'package:sudoku_total/square_collection.dart';

class SelectionNotifier extends ChangeNotifier{
  void setSelectedSquare(int sqInd){
    LogicalBoard.selectedSquare = LogicalBoard.squareModels.firstWhere((element) => element.squareIndex==sqInd);
    notifyListeners();
  }
}

class NumberButtonNotifier extends ChangeNotifier{
  void setNumber(int number){
    LogicalBoard.numberLastClicked = number;
    notifyListeners();
  }
}

class LogicalBoard {
  static final SelectionNotifier selectionNotifier = SelectionNotifier();
  static final NumberButtonNotifier numberButtonNotifier = NumberButtonNotifier();

  static final List<SquareModel> squareModels = _initSquares();
  static final List<SudokuRow> rowsWidgets = _initRowsWidgets();
  static final List<LogicalBox> boxes = _initBoxes();
  static final List<LogicalRow> rows = _initRows();
  static final List<LogicalCol> cols = _initCols();

  static SquareModel? selectedSquare;
  static int numberLastClicked=0;



  static List<LogicalBox> _initBoxes(){
    List<LogicalBox> boxes = [];
    for(var i = 0; i<9; i++){
      boxes.add(LogicalBox(_getBoxSquares(i)));
    }
    return List.unmodifiable(boxes);
  }

  static List<LogicalRow> _initRows(){
    List<LogicalRow> rows = [];
    for(var i = 0; i<9; i++){
      rows.add(LogicalRow(_getRowSquares(i)));
    }
    return List.unmodifiable(rows);
  }

  static List<LogicalCol> _initCols(){
    List<LogicalCol> boxes = [];
    for(var i = 0; i<9; i++){
      boxes.add(LogicalCol(_getColSquares(i)));
    }
    return List.unmodifiable(boxes);
  }

  static List<SudokuRow> _initRowsWidgets() {
    List<SudokuRow> rows = [];
    for(var i = 0; i<9; i++){
      rows.add(SudokuRow(_getRowSquares(i), i));
    }
    return List.unmodifiable(rows);
  }

  static List<SquareModel> _getRowSquares(int rowIndex){
    return List.unmodifiable(squareModels.where((element) => element.rowIndex == rowIndex));
  }

  static List<SquareModel> _getColSquares(int colIndex){
    return List.unmodifiable(squareModels.where((element) => element.colIndex == colIndex));
  }

  static List<SquareModel> _getBoxSquares(int boxIndex){
    return List.unmodifiable(squareModels.where((element) => element.boxIndex == boxIndex));
  }

  static List<SquareModel> _initSquares() {
    List<SquareModel> initSquares = [];
    //Initialise squares with squareIndex, rowIndex, colIndex and boxIndex
    int squareIndex = 0;
    int rowIndex = 0;
    int colStartIndex = 0;
    int colIndex = 0;
    int boxStartIndex = 0;
    int boxIndex = 0;
    for (var count = 1; count < 82; count++) {
      //Add row, col and box index to the new square
      initSquares.add(SquareModel(squareIndex, rowIndex, colIndex, boxIndex));
      //Every square
      //col index increments
      colIndex++;
      //square index increments
      squareIndex++;

      //Every 3 squares
      if (count % 3 == 0) {
        //Box index increments
        boxIndex++;
      }

      //Every 9 squares
      if (count % 9 == 0) {
        //col index goes back to start
        colIndex = colStartIndex;
        //row index increments
        rowIndex++;
        //Box index goes back to the start
        boxIndex = boxStartIndex;
      }

      //Every 27 squares
      if (count % 27 == 0) {
        //Box start index increments by 3
        boxStartIndex = boxStartIndex + 3;
        boxIndex = boxStartIndex;
      }
    }
    return List.unmodifiable(initSquares);
  }

}