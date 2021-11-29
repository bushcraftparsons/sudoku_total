import 'package:sudoku_total/square_collection.dart';
import 'package:sudoku_total/square_model.dart';
import 'package:sudoku_total/utils.dart';

class LevelMaker{
  late final List<SquareModel> squareModels;
  late final List<LogicalBox> boxes;
  late final List<LogicalRow> rows;
  late final List<LogicalCol> cols;

  LevelMaker(this.squareModels, this.boxes, this.rows, this.cols);

  /// Squares which can't be calculated from the board so far
  /// @return
  Set<SquareModel> _getIncalculables(){
    Set<SquareModel> incalculables = {};
    for(SquareModel sq in squareModels){
      if(!sq.isCalculable()){
        incalculables.add(sq);
      }
    }
    return incalculables;
  }

  /// This is the only square in the row, col or box with this answer
  /// @param sq
  void _makeHiddenSingle(SquareModel sq){
    //Make it the only square in the row and col with the answer
    Set<LogicalBox> boxesInRow = sq.row.getBoxes();
    Set<LogicalBox> boxesInCol = sq.col.getBoxes();
    //Remove the box with this square
    boxesInRow.remove(sq.box);
    boxesInCol.remove(sq.box);
    //Now show the solution in the remaining boxes
    for(LogicalBox bx in boxesInRow){
      bx.showSolution(sq.answer);
    }
    for(LogicalBox bx in boxesInCol){
      bx.showSolution(sq.answer);
    }
    sq.calculable = true;
  }

  /// Make an easy level game with only naked and hidden singles
  void makeEasy(){
    Set<SquareModel> incalculables = _getIncalculables();
    while(incalculables.isNotEmpty){
      //Pick a random square from the set of incalculables.
      SquareModel random = Utils.getRandomItemFromSet(incalculables);
      //Just making hidden singles, naked singles occur naturally
      _makeHiddenSingle(random);
      incalculables = _getIncalculables();
    }
  }
}