

import 'package:flutter/material.dart';
import 'package:swurdle_flutter_widgets/flutter_interface.dart';
import 'package:swurdle_flutter_widgets/hexagon.dart';
import 'package:swurdle_flutter_widgets/ui_widget.dart';

class FlutterBoard extends StatelessWidget{

  final List<FlutterHexagon> hexagons = new List();

  @override
  Widget build(BuildContext context) {

    FlutterInterface ui = UI.of(context).ui;

    ui.game.board.tiles.forEach((t){
      hexagons.add(FlutterHexagon(t,ui));
    });


    return Expanded(
      child: Container(
        color: Colors.lightGreenAccent,
        child: FittedBox(
          child: SizedBox(
            height: ui.verticalSize,
            width: ui.horizontalSize,

            child: Stack(


              children: [hexagons[26]],

            ),
          ),
        ),
      ),
    );
  }


}