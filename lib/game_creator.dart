import 'package:sudoku_total/level_maker.dart';
import 'package:sudoku_total/square_collection.dart';
import 'package:sudoku_total/square_model.dart';
import 'package:sudoku_total/utils.dart';

class GameCreator{
  late final List<SquareModel> squareModels;
  late final List<LogicalBox> boxes;
  late final List<LogicalRow> rows;
  late final List<LogicalCol> cols;


  GameCreator(this.squareModels, this.boxes, this.rows, this.cols);

  void createGame(){
    for(SquareModel sq in squareModels){
      sq.reset();
    }
    //Create new sudoku solution
    createSolution();
    LevelMaker lm = LevelMaker(squareModels, boxes, rows, cols);
    lm.makeEasy();

    //TODO Save game state to persistent storage
  }

  void createSolution (){
    for(SquareModel sq in squareModels){
      int countBacktracks = 1;
      while(!_processSquare(sq)){//If successful, then carrying on
        //There was no value for this square, need to backtrack
        sq.answer = 0;
        _backtrack(sq, countBacktracks);
        countBacktracks++;
      }
    }
  }

  bool _processSquare(SquareModel sq){
    //Iterate the squares one row at a time.
    Set possibles = sq.possibleAnswers();
    int? possibleAnswer = Utils.getRandomItemFromSet(possibles);
    while(possibleAnswer != null && !_tryAnswer(sq, possibleAnswer)){
      //Answer was no good
      //Remove it from possibles
      possibles.remove(possibleAnswer);
      possibleAnswer = Utils.getRandomItemFromSet(possibles);
    }
    return possibleAnswer != null;
  }

  void _backtrack(SquareModel sq, int numberBackTracks){
    int startIndex = sq.squareIndex - numberBackTracks;
    //Back track squares should be exclusive of the original square
    List<SquareModel> backTrackSquares = squareModels.sublist(startIndex, sq.squareIndex);
    //Set possible answers to null except for the first square
    //Set all backtrack square to null answers
    for(SquareModel square in backTrackSquares){
      square.answer = 0;
    }
    //Now process them again
    for(SquareModel square in backTrackSquares){
      _processSquare(square);
    }
  }

  bool _tryAnswer(SquareModel square, int possibleAnswer){
    //Try an answer
    square.answer = possibleAnswer;
    //For rest of squares, make sure all still have a possible answer
    if(_passRestOfSquareCheck(square)){
      if(_passBoxCheck(square)) {
        if(_passColCheck(square)) {
          if(_passRowCheck(square)) {
            if(_passPossibleValuesCheck(square)) {
              //Answer is fine, continue
              return true;
            }
          }
        }
      }
    }
    //Answer was no good.
    square.answer = 0;
    return false;
  }

  /// Helper method for creating a sudoku solution
  /// For rest of squares, make sure all still have a possible answer
  /// @param square The square to be checked
  /// @return Returns true if there is still a possible answer for this square, false if not
  bool _passRestOfSquareCheck (SquareModel square){
    for(int index = square.squareIndex + 1; index<squareModels.length; index++){
      SquareModel sq = squareModels[index];
      if(sq.possibleAnswers().isEmpty){
        return false;
      }
    }
    return true;
  }

  bool _passBoxCheck (SquareModel square){
    int rowNumber = square.rowIndex;
    int boxNumber = square.boxIndex;
    int endBox = 2;
    if(boxNumber>2){
      endBox = 5;
    }
    if(boxNumber>5){
      endBox = 8;
    }
    boxNumber = boxNumber + 1;
    while(boxNumber<=endBox){
      int numberPossibleAnswersForRow = boxes[boxNumber].getPossibleAnswersForRow(rowNumber).length;
      if(numberPossibleAnswersForRow < boxes[boxNumber].getSquaresInRowWithNoAnswer(rowNumber).length){
        return false;
      }
      boxNumber++;
    }
    return true;
  }

  bool _passColCheck(SquareModel square){
    //Iterate rest of columns
    for(int colIndex = square.colIndex + 1; colIndex<cols.length; colIndex++){
      LogicalCol checkCol = cols[colIndex];
      List<SquareModel> squaresWithNoAnswer = checkCol.getSquaresWithNoAnswer();
      Set possibles = {};
      for(SquareModel sq in squaresWithNoAnswer){
        possibles.addAll(sq.possibleAnswers());
      }
      //Same number of possible answers as there are squares
      if(possibles.length==squaresWithNoAnswer.length){
        for(int possAnswer in possibles){
            if(!square.row.containsAnswer(possAnswer)){
              return true;//At least one answer not already contained in row
            }
        }
        return false;
      }
    }
    return true;
  }

  bool _passRowCheck(SquareModel sq){
    //If there are two squares in the row with only one possible answer which match, then fail
    List<SquareModel> squaresWithOneAnswer = sq.row.getSquaresWithOneAnswer();
    Set possibles = {};
    for(SquareModel square in squaresWithOneAnswer){
      possibles.addAll(square.possibleAnswers());
    }
    return squaresWithOneAnswer.length == possibles.length;
  }

  bool _passPossibleValuesCheck(SquareModel sq){
    //If, looking at answer values and possible value, there are 9 values, then pass
    Set<int> allValues = {};
    allValues.addAll(sq.row.getPossibleAnswers());
    allValues.addAll(sq.row.getValues());
    return allValues.length==9;
  }
}