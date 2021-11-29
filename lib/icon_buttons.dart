import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'logical_board.dart' as board;

class IconButtons extends StatelessWidget {
  const IconButtons({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisSize: MainAxisSize.min, children: const [
      Expanded(child: IconButton(board.Action.usePen)),
      Expanded(child: IconButton(board.Action.erase)),
      Expanded(child: IconButton(board.Action.hint)),
      Expanded(child: IconButton(board.Action.newGame)),
      Expanded(child: IconButton(board.Action.pause)),
      Expanded(child: IconButton(board.Action.undo)),
    ]);
  }
}

class IconButton extends StatefulWidget {
  static const String penIcon = 'assets/pennib.svg';
  static const String pencilIcon = 'assets/penciltip.svg';
  static const String eraseIcon = 'assets/eraser.svg';
  static const String undoIcon = 'assets/undo.svg';
  static const String pauseIcon = 'assets/pause.svg';
  static const String hintIcon = 'assets/hint.svg';
  static const String newGameIcon = 'assets/newGame.svg';
  final board.Action _action;
  const IconButton(
    this._action, {
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => IconButtonState();
}

class IconButtonState extends State<IconButton> with TickerProviderStateMixin {
  late Color mainButtonColour;
  late String _svg;
  late DecorationTween decorationTween;

  @override
  void didChangeDependencies() {
    mainButtonColour = (board.LogicalBoard().pen)
        ? Theme.of(context).primaryColor
        : Theme.of(context).colorScheme.secondary;
    _svg = getSvg();
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
          _svg = getSvg();
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
        });
    });

    super.didChangeDependencies();
  }

  String getSvg() {
    switch (widget._action) {
      case board.Action.usePen:
        if (board.LogicalBoard().pen) {
          return IconButton.penIcon;
        } else {
          return IconButton.pencilIcon;
        }
      case board.Action.undo:
        return IconButton.undoIcon;
      case board.Action.pause:
        return IconButton.pauseIcon;
      case board.Action.newGame:
        return IconButton.newGameIcon;
      case board.Action.hint:
        return IconButton.hintIcon;
      case board.Action.erase:
        return IconButton.eraseIcon;
      default:
        return IconButton.penIcon;
    }
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
        switch (widget._action) {
          case board.Action.usePen:
            board.LogicalBoard().usePenChange.setPen(!board.LogicalBoard().pen);
            break;
          case board.Action.erase:
            board.LogicalBoard().erase();
            break;
          case board.Action.hint:
            break;
          case board.Action.newGame:
            break;
          case board.Action.pause:
            break;
          case board.Action.undo:
            break;
          default:
        }
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
                child: SvgPicture.asset(
              _svg,
              color: Theme.of(context).primaryColorDark,
              height: 45,
              width: 45,
            )),
          )),
    ));
  }
}
