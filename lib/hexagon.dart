
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:swurdle_flutter_widgets/flutter_interface.dart';
import 'package:swurdlelogic/swurdlelogic.dart';

class FlutterHexagon extends StatefulWidget{

  final Tile tile;
  final FlutterInterface ui;
  HexState state;


  FlutterHexagon(this.tile, this.ui);

  @override
  HexState createState() {

    state = HexState(tile, ui);

    return state;
  }

  updateState(){
    state?.setState((){
      state.color = ui.getColor(tile.color);
      state.setVariables();
    });

  }

  reset(){
    state.setState((){
      state.setVariables();
    });

  }

}

class HexState extends State<FlutterHexagon>{

  final Tile tile;
  final FlutterInterface ui;
  Color color;

  HexState(this.tile, this.ui){
    setVariables();
    color = ui.getColor(tile.color);
  }

  double hexSize;
  double homeX;
  double homeY;
  double defaultScale;

  @override
  Widget build(BuildContext context) {

    String letter = ui.letters[tile.k];

    return Positioned(
      left: homeX,
      top: homeY,

      child: Container(
        color: color,
        child: SizedBox(
          height: hexSize,
          width: hexSize,
          child: GestureDetector(

            onTapUp: (d){
              setState(() {
                ui.select(tile);
                ui.board.update();
                setVariables();
              });
            },

            onPanDown: (d){},

            onPanUpdate: (d){

              setState(() {
                homeX = d.globalPosition.dx;
                homeY = d.globalPosition.dy;
              });



            },

            onPanEnd: (d){
              setState(() {
                color = ui.getColor(tile.color);
                setVariables();
              });
            },

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
      ),
    );
  }



  setVariables(){

    hexSize = ui.smallDimension / ui.game.size * 0.75;

    double hexagonSpacingVertical = hexSize * 1.2;
    double hexagonSpacingHorizontal = hexSize * 1.2;

    homeX = tile.i * hexagonSpacingHorizontal + hexagonSpacingHorizontal/2 ;
    homeY = tile.j * hexagonSpacingVertical + hexagonSpacingVertical/2 ;
    if(tile.i.isEven) homeY += hexagonSpacingVertical/2;

  }


}

