import 'dart:math';

abstract class Utils{
  static final _random = Random();
  static getRandomItemFromSet(Set mySet){
    if(mySet.isEmpty){
      return null;
    }
    int maxIndex = mySet.length;
    int randomIndex = _random.nextInt(maxIndex);
    return mySet.elementAt(randomIndex);
  }
}