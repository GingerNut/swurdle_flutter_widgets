
import 'dart:async';
import 'dart:ui';
import 'package:flutter/services.dart';
import 'package:swurdlelogic/swurdlelogic.dart';
import 'package:flutter/material.dart';


AssetBundle _initBundle() {
  if (rootBundle != null)
    return rootBundle;
  return new NetworkAssetBundle(new Uri.directory(Uri.base.origin));
}

final AssetBundle _bundle = _initBundle();

class FlutterInterface extends Interface{

  Future<String> loadString(String fileName) async{
    return await _bundle.loadString('packages/swurdlelogic/assets/' + fileName);
  }

   static Color getColor(int color){
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

      case Board.COLOR_WORD_DISSOLVED:
        return Colors.pinkAccent;

      case Board.COLOR_MOVE_GOOD:
        return Colors.green;

      case Board.COLOR_LETTER_DARK:
        return Colors.black;

      case Board.COLOR_LETTER_LIGHT:
        return Colors.white;

    }


    return null;
   }



  }


