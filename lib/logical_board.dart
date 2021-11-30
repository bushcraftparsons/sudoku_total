import 'package:flutter/cupertino.dart';
import 'package:sudoku_total/square_model.dart';
import 'package:sudoku_total/state_persistor.dart';
import 'package:sudoku_total/sudoku_row.dart';
import 'package:sudoku_total/square_collection.dart';

import 'game_creator.dart';
enum Action {
  usePen,
  erase,
  undo,
  newGame,
  hint,
  pause
}

enum Level {
  easy
}

class UsePenChange extends ChangeNotifier{
  void setPen(bool usePen){
    LogicalBoard().pen = usePen;
    for(SquareModel sq in LogicalBoard().squareModels){
      sq.penChanged();
    }
    notifyListeners();
  }
}

class LogicalBoard {
  static final LogicalBoard _instance = LogicalBoard._internal();

  factory LogicalBoard(){
    return _instance;
  }

  LogicalBoard._internal(){
    squareModels = _initSquares();
    rowsWidgets = _initRowsWidgets();
    boxes = _initBoxes();
    rows = _initRows();
    cols = _initCols();
    usePenChange = UsePenChange();
    pen = false;
    gm = GameCreator(squareModels, boxes, rows, cols);
  }

  late final List<SquareModel> squareModels;
  late final List<SudokuRow> rowsWidgets;
  late final List<LogicalBox> boxes;
  late final List<LogicalRow> rows;
  late final List<LogicalCol> cols;
  late final UsePenChange usePenChange;
  late bool pen;
  late final GameCreator gm;

  SquareModel? selectedSquare;

  void setState(Map<String, dynamic> state){
    pen = state['pen'] as bool;
    for(Map<String,dynamic> squareState in state['squareStateModels'] as List<dynamic>){
      SquareModel sq = squareModels.where((element) => element.squareIndex==squareState['squareIndex']).first;
      sq.setSquareState(squareState);
    }
  }

  void newGame(Level lvl){
    for(SquareModel sq in squareModels){
      sq.reset();
    }
    gm.createGame(lvl);
    //Save the game state
    writeState(getLogicalBoardState());
  }

  Map<String, Object> getLogicalBoardState() {
    List<Map<String, Object>> squareStateModels = [];
    for(SquareModel sq in squareModels){
      squareStateModels.add(sq.getSquareState());
    }
    return {
      'squareStateModels': squareStateModels,
      'pen': pen
    };
  }

  void setNumber(int number){
    if(selectedSquare != null){
      selectedSquare?.number = number;
    }
    //Save the game state
    writeState(getLogicalBoardState());
  }

  void erase(){
    if(selectedSquare != null){
      selectedSquare?.erase();
    }
    //Save the game state
    writeState(getLogicalBoardState());
  }

  void setSelectedSquare(int squareIndex){
    selectedSquare = squareModels[squareIndex];
    for (var sm in squareModels) {
      sm.selected = (sm.squareIndex==squareIndex);
      sm.selectedCollection = sm.boxIndex==selectedSquare?.boxIndex || sm.rowIndex==selectedSquare?.rowIndex || sm.colIndex==selectedSquare?.colIndex;
    }
  }

  void showAnswers(){
    for(SquareModel sq in squareModels){
      sq.showAnswer();
    }
  }

  List<LogicalBox> _initBoxes(){
    List<LogicalBox> boxes = [];
    for(var i = 0; i<9; i++){
      boxes.add(LogicalBox(_getBoxSquares(i)));
    }
    for(SquareModel sq in squareModels){
      sq.box = boxes[sq.boxIndex];
    }
    return List.unmodifiable(boxes);
  }

  List<LogicalRow> _initRows(){
    List<LogicalRow> rows = [];
    for(var i = 0; i<9; i++){
      rows.add(LogicalRow(_getRowSquares(i)));
    }
    for(SquareModel sq in squareModels){
      sq.row = rows[sq.rowIndex];
    }
    return List.unmodifiable(rows);
  }

  List<LogicalCol> _initCols(){
    List<LogicalCol> cols = [];
    for(var i = 0; i<9; i++){
      cols.add(LogicalCol(_getColSquares(i)));
    }
    for(SquareModel sq in squareModels){
      sq.col = cols[sq.colIndex];
    }
    return List.unmodifiable(cols);
  }

  List<SudokuRow> _initRowsWidgets() {
    List<SudokuRow> rows = [];
    for(var i = 0; i<9; i++){
      rows.add(SudokuRow(_getRowSquares(i), i));
    }
    return List.unmodifiable(rows);
  }

  List<SquareModel> _getRowSquares(int rowIndex){
    return List.unmodifiable(squareModels.where((element) => element.rowIndex == rowIndex));
  }

  List<SquareModel> _getColSquares(int colIndex){
    return List.unmodifiable(squareModels.where((element) => element.colIndex == colIndex));
  }

  List<SquareModel> _getBoxSquares(int boxIndex){
    return List.unmodifiable(squareModels.where((element) => element.boxIndex == boxIndex));
  }

  List<SquareModel> _initSquares() {
    List<SquareModel> initSquares = [];
    //Initialise squares with squareIndex, rowIndex, colIndex and boxIndex
    int squareIndex = 0;
    int rowIndex = 0;
    int colStartIndex = 0;
    int colIndex = 0;
    int boxStartIndex = 0;
    int boxIndex = 0;
    for (var count = 1; count < 82; count++) {
      SquareModel newSquare = SquareModel(squareIndex, rowIndex, colIndex, boxIndex);
      //Add row, col and box index to the new square
      initSquares.add(newSquare);
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