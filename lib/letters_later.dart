

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:swurdle_flutter_widgets/flutter_interface.dart';
import 'package:swurdle_flutter_widgets/ui_widget.dart';
import 'package:swurdlelogic/swurdlelogic.dart';

class LettersLayer extends StatelessWidget {


  final List<Widget> pieces = new List();

  Widget build(BuildContext context) {
    FlutterInterface ui = UI
        .of(context)
        .ui;

    ui.tiles.forEach((t) {
      pieces.add(FlutterLetter(t));
    });

    return Stack(

      children: pieces,

    );
  }
}

  class FlutterLetter extends StatelessWidget{
    final Tile tile;

  const FlutterLetter(this.tile);

  @override
  Widget build(BuildContext context) {

    FlutterInterface ui = UI.of(context).ui;

    return  Positioned(
      left: tile.homeX,
      top: tile.homeY,

      child: GestureDetector(
        onTapUp: (d) => ui.select(tile),

        child: Container(
          height: tile.hexSize,
          width: tile.hexSize,

          child: FittedBox(
          child: StreamBuilder<GameMessage>(
            stream: ui.events.stream,
            builder: (context, snapshot) {

              return Text(

              ui.position.wordOwnerBoard != null && ui.position.wordOwnerBoard[tile.k] != null ?  '' : ui.letters[tile.k],
              style: TextStyle(
              color: Colors.black
              ),
              );
            }
          ),
          ),
        ),
      ),
    );
  }




  }