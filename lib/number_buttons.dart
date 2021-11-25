import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'logical_board.dart';

class NumberButtons extends StatelessWidget {
  const NumberButtons({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisSize: MainAxisSize.min, children: const [
      NumberButton(1),
      NumberButton(2),
      NumberButton(3),
      NumberButton(4),
      NumberButton(5),
      NumberButton(6),
      NumberButton(7),
      NumberButton(8),
      NumberButton(9)
    ]);
  }
}

class NumberButton extends StatelessWidget {
  final int _number;
  const NumberButton(
    this._number, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () => LogicalBoard.numberButtonNotifier.setNumber(_number),
        child: Align(
          child: Container(
            height: 100,
            width: 50,
            margin: EdgeInsets.all(1.0),
            decoration: new BoxDecoration(
              gradient: RadialGradient(
                radius: 0.8,
                colors: [
                  Theme.of(context).canvasColor,
                  Theme.of(context).primaryColor,
                ],
              ),
              border: Border.all(
                  color: Theme.of(context).primaryColorDark, width: 2.0),
              borderRadius: new BorderRadius.all(Radius.elliptical(50, 100)),
            ),
            child: Center(
                child: Text(_number.toString(),
                    style: Theme.of(context).textTheme.headline4)),
          ),
        ));
  }
}
