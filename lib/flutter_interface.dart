
import 'dart:async';
import 'dart:ui';
import 'package:flutter/services.dart';

import 'package:flutter/material.dart';
import 'package:swurdlelogic/swurdlelogic.dart';


AssetBundle _initBundle() {
  if (rootBundle != null)
    return rootBundle;
  return new NetworkAssetBundle(new Uri.directory(Uri.base.origin));
}

final AssetBundle _bundle = _initBundle();

class FlutterInterface extends SwurdleInterface{

  Future<String> loadString(String fileName) async{
    return await _bundle.loadString('packages/swurdlelogic/assets/' + fileName);
  }

   static Color getColor(int color){
    switch(color){

      case Palette.COLOR_BLACK:
        return Colors.black;

      case Palette.COLOR_WHITE:
        return Colors.white;

      case Palette.COLOR_NONE:
        return Colors.amberAccent;

      case Palette.COLOR_BLUE:
        return Colors.blue;

      case Palette.COLOR_GOLD:
        return Colors.amber;

      case Palette.COLOR_GREY:
        return Colors.grey;

      case Palette.COLOR_PURPLE:
        return Colors.purple;

      case Palette.COLOR_RED:
        return Colors.red;

      case Palette.COLOR_SELECTED:
        return Colors.brown;

      case Palette.COLOR_WORD_DISSOLVED:
        return Colors.pinkAccent;

      case Palette.COLOR_MOVE_GOOD:
        return Colors.green;

      case Palette.COLOR_LETTER_DARK:
        return Colors.black;

      case Palette.COLOR_LETTER_LIGHT:
        return Colors.white;

    }


    return null;
   }



  }


