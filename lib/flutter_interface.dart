
import 'dart:async';
import 'dart:ui';
import 'package:flutter/services.dart';
import 'package:swurdle_flutter_widgets/board.dart';
import 'package:swurdle_flutter_widgets/hexagon.dart';
import 'package:swurdle_flutter_widgets/ui_widget.dart';
import 'package:swurdlelogic/swurdlelogic.dart';
import 'package:flutter/material.dart';


AssetBundle _initBundle() {
  if (rootBundle != null)
    return rootBundle;
  return new NetworkAssetBundle(new Uri.directory(Uri.base.origin));
}

final AssetBundle _bundle = _initBundle();


class FlutterInterface extends Interface{

  FlutterBoardState board;
  final List<HexModel> hexagons = new List();

  HexModel model(Tile tile) => hexagons[tile.k];
  List<StreamController<GameState>> hexUpates = new List();


  Future<String> loadString(String fileName) async{
    return await _bundle.loadString('packages/swurdlelogic/assets/' + fileName);
  }


  setUpNewGame(){

    hexagons.clear();

    tiles.forEach((t) {
      hexagons.add(HexModel(this, t));
    });


  }

  setUpNewPosition(){}

  Tile getTile(Offset offset){

    Tile tile;

    hexagons.forEach((h){
      if(h.contains(offset)) tile = h.tile;
    });

    return tile;
  }


   Color getColor(int color){
    switch(color){
      case Board.COLOR_NONE:
        return Colors.amberAccent;

      case Board.COLOR_BLUE:
        return Colors.blue;

      case Board.COLOR_GOLD:
        return Colors.amber;

      case Board.COLOR_GREY:
        return Colors.grey;

      case Board.COLOR_PURPLE:
        return Colors.purple;

      case Board.COLOR_RED:
        return Colors.red;

      case Board.COLOR_SELECTED:
        return Colors.brown;

      case Board.COLOR_WORD_BAD:
        return Colors.red;

      case Board.COLOR_WORD_DISSOLVED:
        return Colors.pinkAccent;

      case Board.COLOR_WORD_GOOD:
        return Colors.green;




    }


    return null;
   }

  @override
  redraw() {

  }



  }


