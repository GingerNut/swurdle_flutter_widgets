

import 'package:flutter/material.dart';
import 'package:swurdle_flutter_widgets/flutter_interface.dart';
import 'package:swurdlelogic/swurdlelogic.dart';

class FlutterHexagon extends StatelessWidget{

  final Tile tile;
  final FlutterInterface ui;

  FlutterHexagon(this.tile, this.ui){




  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return null;
  }





  setVariables(){
    const padding = 1.0;
    const horizontal_packing = 0.75;



    hexSize = min(GameBoard.HORIZONTAL_SIZE / ui.game.size * root3over2 /1.63, GameBoard.VERTICAL_SIZE/ ui.game.size * root3over2 / 1.45);

    hexSize /= 1.8;

    double hexagonSpacingVertical = hexSize * (2 + padding * 2) * root3over2;
    double hexagonSpacingHorizontal = hexSize * (2 + padding * 2) * horizontal_packing;

    double horizontalPadding = (GameBoard.HORIZONTAL_SIZE - hexagonSpacingHorizontal * ui.game.size)/2;
    double verticalPadding = (GameBoard.VERTICAL_SIZE - hexagonSpacingVertical * ui.game.size)/2 ;



    homeX = tile.i * hexagonSpacingHorizontal + hexagonSpacingHorizontal ;
    homeY = tile.j * hexagonSpacingVertical + hexagonSpacingVertical ;
    if(tile.i.isEven) homeY += verticalPadding/2;


    defaultScale = 0.78;
  }

}