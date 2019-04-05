

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:swurdle_flutter_widgets/flutter_interface.dart';
import 'package:swurdle_flutter_widgets/hexagon.dart';
import 'package:swurdle_flutter_widgets/ui_widget.dart';
import 'package:swurdle_flutter_widgets/words_layer.dart';

class FlutterBoard extends StatefulWidget{

  @override
  FlutterBoardState createState() => FlutterBoardState();
}

class FlutterBoardState extends State<FlutterBoard> {

  final List<Widget> pieces = new List();
  FlutterInterface ui;

  @override
  Widget build(BuildContext context) {

    ui = UI.of(context).ui;

    ui.hexUpates.clear();


    ui.tiles.forEach((t){

      pieces.add(FlutterHexagon(t,ui, ui.model(t)));

    });

    ui.tiles.forEach((t){

      ui.hexUpates.add(StreamController<GameState>());

    });



   pieces.add(WordsLayer());


    return StreamBuilder<GameState>(
      stream: UI.of(context).events.stream,
      builder: (context, snapshot) {

        if(snapshot != null && snapshot.data != null){
          if(snapshot.data.valid == false){

            ui.hexUpates.forEach((u) => u.add(GameState()..valid = false));

          }
        }

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
    );
  }

}

