
import 'package:flutter/material.dart';
import 'package:swurdle_flutter_widgets/flutter_interface.dart';
import 'package:swurdle_flutter_widgets/hexagon.dart';
import 'package:swurdle_flutter_widgets/ui_widget.dart';
import 'package:swurdle_flutter_widgets/words_layer.dart';
import 'package:swurdlelogic/swurdlelogic.dart';

class FlutterBoard extends StatelessWidget {

  final List<Widget> pieces = new List();

  @override
  Widget build(BuildContext context) {

    FlutterInterface ui = UI
        .of(context)
        .ui;

    ui.tiles.forEach((t) {
      pieces.add(FlutterHexagon(t));
    });

    pieces.add(WordsLayer());

    return Expanded(
      child: Container(
        color: Colors.lightGreenAccent,
        child: FittedBox(
          child: SizedBox(
            height: ui.verticalSize,
            width: ui.horizontalSize,

            child: Stack(

              children: pieces,

            ),
          ),
        ),
      ),
    );
  }

}


