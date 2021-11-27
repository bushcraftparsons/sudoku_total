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
      Expanded(child: NumberButton(1)),
      Expanded(child: NumberButton(2)),
      Expanded(child: NumberButton(3)),
      Expanded(child: NumberButton(4)),
      Expanded(child: NumberButton(5)),
      Expanded(child: NumberButton(6)),
      Expanded(child: NumberButton(7)),
      Expanded(child: NumberButton(8)),
      Expanded(child: NumberButton(9))
    ]);
  }
}

class NumberButton extends StatefulWidget {
  final int _number;
  const NumberButton(
    this._number, {
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => NumberButtonState();
}

class NumberButtonState extends State<NumberButton>
    with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 5),
      reverseDuration: const Duration(milliseconds: 200),
      animationBehavior: AnimationBehavior.preserve);

  void repeatAnimationOnce() async {
    await _controller.forward();
    await _controller.reverse();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final DecorationTween decorationTween = DecorationTween(
      begin: BoxDecoration(
        gradient: RadialGradient(
          radius: 0.8,
          colors: [
            Theme.of(context).primaryColor,
            Theme.of(context).primaryColor,
          ],
        ),
        border:
            Border.all(color: Theme.of(context).primaryColorDark, width: 2.0),
        borderRadius: const BorderRadius.all(Radius.elliptical(50, 100)),
      ),
      end: BoxDecoration(
        gradient: RadialGradient(
          radius: 0.8,
          colors: [
            Theme.of(context).canvasColor,
            Theme.of(context).primaryColor,
          ],
        ),
        border: Border.all(color: Theme.of(context).primaryColor, width: 5.0),
        borderRadius: const BorderRadius.all(Radius.elliptical(50, 100)),
      ),
    );

    return Align(
        child: GestureDetector(
      onTap: () {
        repeatAnimationOnce();
        LogicalBoard.setNumber(widget._number);
      },
      child: SizedBox(
          width: 50,
          height: 100,
          child: DecoratedBoxTransition(
            position: DecorationPosition.background,
            decoration: decorationTween.animate(CurvedAnimation(
                parent: _controller,
                curve: Curves.decelerate,
                reverseCurve: Curves.easeOut)),
            child: Center(
                child: Text(widget._number.toString(),
                    style: Theme.of(context).textTheme.headline4)),
          )),
    ));
  }
}
