import 'package:flutter/cupertino.dart';
import 'package:sudoku_total/square_model.dart';


abstract class SquareCollection {
  final List<SquareModel> squareList;
  const SquareCollection(this.squareList, {
    Key? key,
  });

  /// Get the answer values from the squares
  /// @return Returns all the values which could be used in the solution for this collection of squares
  Set<int> getValues(){
    Set<int> values = {};
    for(SquareModel sq in squareList){
      int? sqAnswer = sq.answer;
      if(sqAnswer!= null){
        values.add(sqAnswer);
      }
    }
    return values;
  }

  Set<int> getPossibleAnswers(){
    Set<int> result = {};
    for(SquareModel square in squareList){
      if(square.answer==null){
        result.addAll(square.possibleAnswers());
      }
    }
    return result;
  }

  /// Checks values and removes values already contained from the set
  /// @param possibles the possible values for an answer from which duplicates are to be removed
  void removeDuplicates(Set<int> possibles){
    possibles.removeAll(getValues());
  }

  List<SquareModel> getSquaresWithNoAnswer(){
    List<SquareModel> result = [];
    for(SquareModel sq in squareList){
      if(sq.answer == null){
        result.add(sq);
      }
    }
    result.sort(squareComparator);
    return result;
  }

  bool containsAnswer(int answer){
    for(SquareModel sq in squareList){
      if(sq.answer != null && sq.answer == answer){
        return true;
      }
    }
    return false;
  }

  List<SquareModel> getSquaresWithOneAnswer(){
    List<SquareModel> result = [];
    for(SquareModel sq in squareList){
      if(sq.answer==null && sq.possibleAnswers().length==1){
        result.add(sq);
      }
    }
    result.sort(squareComparator);
    return result;
  }

}

class LogicalRow extends SquareCollection {
  LogicalRow(List<SquareModel> squareList) : super(squareList);

}

class LogicalCol extends SquareCollection {
  LogicalCol(List<SquareModel> squareList) : super(squareList);

}

class LogicalBox extends SquareCollection {
  LogicalBox(List<SquareModel> squareList) : super(squareList);

  Set<int> getPossibleAnswersForRow(int rowNumber){
    Set<int> result = {};
    for(SquareModel sq in squareList){
      if(sq.rowIndex==rowNumber && sq.answer==null){
        result.addAll(sq.possibleAnswers());
      }
    }
    return result;
  }

  List<SquareModel> getSquaresInRowWithNoAnswer(int rowNumber){
    List<SquareModel> results = [];
    for(SquareModel sq in squareList){
      if(sq.rowIndex==rowNumber && sq.answer==null){
        results.add(sq);
      }
    }
    results.sort(squareComparator);
    return results;
  }

}

