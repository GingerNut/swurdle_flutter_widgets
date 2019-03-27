

import 'package:flutter/material.dart';
import 'package:swurdle_flutter_widgets/flutter_interface.dart';
import 'package:swurdle_flutter_widgets/hexagon.dart';

class FlutterBoard extends StatelessWidget{

  final FlutterInterface ui;

  List<FlutterHexagon> hexagons = new List();


  FlutterBoard(this.ui){
    ui.game.board.tiles.forEach((t){
      hexagons.add(FlutterHexagon(t,ui));
    });

  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
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
    );;
  }


}