

import 'package:flutter/material.dart';
import 'package:swurdle_flutter_widgets/flutter_interface.dart';
import 'package:swurdle_flutter_widgets/hexagon.dart';
import 'package:swurdle_flutter_widgets/ui_widget.dart';
import 'package:swurdle_flutter_widgets/word.dart';

class FlutterBoard extends StatefulWidget{

  @override
  FlutterBoardState createState() => FlutterBoardState();
}

class FlutterBoardState extends State<FlutterBoard> {
  final List<FlutterHexagon> hexagons = new List();
  final List<FlutterWord> words = new List();
  final List<Widget> pieces = new List();
  FlutterInterface ui;

  @override
  Widget build(BuildContext context) {

    ui = UI.of(context).ui;

    ui.board = this;

    ui.tiles.forEach((t){
      hexagons.add(FlutterHexagon(t,ui));
      pieces.addAll(hexagons);

    });

    ui.position.words.words.forEach((w){
      pieces.add(FlutterWord(w));
    });


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

  update(){

    hexagons.forEach((h){
      h.updateState();
    });
    

    ui.position.words.words.forEach((w){

      bool alreadyIn = false;

      words.forEach((fw){
        if(fw.word == w) alreadyIn = true;
      });

      if(!alreadyIn) {
        words.add(FlutterWord(w));
        print('adding word');
      }

    });


    setState(() {
      pieces.clear();
      pieces.addAll(hexagons);
      pieces.addAll(words);
    });


  }
}