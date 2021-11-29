import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' hide IconButton;
import 'package:flutter_svg/svg.dart';

import 'icon_buttons.dart';
import 'logical_board.dart' as board;

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
  late Color mainButtonColour;
  late String _svg;
  late DecorationTween decorationTween;

  @override
  void didChangeDependencies() {
    mainButtonColour = (board.LogicalBoard().pen)
        ? Theme.of(context).primaryColor
        : Theme.of(context).colorScheme.secondary;
    _svg =
        (board.LogicalBoard().pen) ? IconButton.penIcon : IconButton.pencilIcon;
    decorationTween = DecorationTween(
      begin: BoxDecoration(
        gradient: RadialGradient(
          radius: 0.8,
          colors: [
            mainButtonColour,
            mainButtonColour,
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
            mainButtonColour,
          ],
        ),
        border: Border.all(color: Theme.of(context).primaryColor, width: 5.0),
        borderRadius: const BorderRadius.all(Radius.elliptical(50, 100)),
      ),
    );

    board.LogicalBoard().usePenChange.addListener(() {
      setState(() {
        mainButtonColour = (board.LogicalBoard().pen)
            ? Theme.of(context).primaryColor
            : Theme.of(context).colorScheme.secondary;
        _svg = (board.LogicalBoard().pen)
            ? IconButton.penIcon
            : IconButton.pencilIcon;
        decorationTween = DecorationTween(
          begin: BoxDecoration(
            gradient: RadialGradient(
              radius: 0.8,
              colors: [
                mainButtonColour,
                mainButtonColour,
              ],
            ),
            border: Border.all(
                color: Theme.of(context).primaryColorDark, width: 2.0),
            borderRadius: const BorderRadius.all(Radius.elliptical(50, 100)),
          ),
          end: BoxDecoration(
            gradient: RadialGradient(
              radius: 0.8,
              colors: [
                Theme.of(context).canvasColor,
                mainButtonColour,
              ],
            ),
            border:
                Border.all(color: Theme.of(context).primaryColor, width: 5.0),
            borderRadius: const BorderRadius.all(Radius.elliptical(50, 100)),
          ),
        );
      });
    });

    super.didChangeDependencies();
  }

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
    return Align(
        child: GestureDetector(
      onTap: () {
        repeatAnimationOnce();
        board.LogicalBoard().setNumber(widget._number);
      },
      child: Container(
        padding: const EdgeInsets.all(2.0),
          width: 50,
          height: 100,
          child: DecoratedBoxTransition(
            position: DecorationPosition.background,
            decoration: decorationTween.animate(CurvedAnimation(
                parent: _controller,
                curve: Curves.decelerate,
                reverseCurve: Curves.easeOut)),
            child: Stack(
                alignment: Alignment.center,
                fit: StackFit.loose,
                clipBehavior: Clip.hardEdge,
                children: [
                  Text(widget._number.toString(),
                      style: Theme.of(context).textTheme.headline4),
                   Positioned(
                          top: 5,
                          right: 10,
                          child: Transform.rotate(
                              angle: 45 * pi / 180,
                              child:SvgPicture.asset(
                            _svg,
                            color: Theme.of(context).primaryColorDark,
                            height: 25,
                            width: 25,
                          )))
                ]),
          )),
    ));
  }
}
