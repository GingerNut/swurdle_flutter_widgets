
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:swurdle_flutter_widgets/flutter_interface.dart';
import 'package:swurdlelogic/swurdlelogic.dart';

class FlutterHexagon extends StatefulWidget{

  final Tile tile;
  final FlutterInterface ui;

  FlutterHexagon(this.tile, this.ui);

  @override
  HexState createState() => HexState(tile, ui);

}

class HexState extends State<FlutterHexagon>{

  final Tile tile;
  final FlutterInterface ui;

  HexState(this.tile, this.ui){
    setVariables();
  }

  double hexSize;
  double homeX;
  double homeY;
  double defaultScale;

  @override
  Widget build(BuildContext context) {

    String letter = ui.position.letters[tile.k];

    return Positioned(
      left: homeX,
      top: homeY,

      child: Container(
        color: Colors.amberAccent,
        child: SizedBox(
          height: hexSize,
          width: hexSize,
          child: FittedBox(
              child: Text(
                  letter,
                style: TextStyle(
                  color: Colors.black
                ),
              ),
          ),
        ),
      ),
    );
  }



  setVariables(){
    const padding = 1.0;
    const horizontal_packing = 0.75;
    const root3over2 = 1.22474487131915;



    hexSize = min(ui.horizontalSize / ui.game.size * root3over2 /2.7, ui.verticalSize/ ui.game.size * root3over2 / 2.5);

    hexSize /= 1.8;

    double hexagonSpacingVertical = hexSize * (2 + padding * 2) * root3over2;
    double hexagonSpacingHorizontal = hexSize * (2 + padding * 2) * horizontal_packing;

    double horizontalPadding = (ui.horizontalSize - hexagonSpacingHorizontal * ui.game.size)/2;
    double verticalPadding = (ui.verticalSize - hexagonSpacingVertical * ui.game.size)/2 ;

    homeX = tile.i * hexagonSpacingHorizontal + hexagonSpacingHorizontal ;
    homeY = tile.j * hexagonSpacingVertical + hexagonSpacingVertical ;
    if(tile.i.isEven) homeY += verticalPadding/2;

    defaultScale = 0.78;
  }


}

