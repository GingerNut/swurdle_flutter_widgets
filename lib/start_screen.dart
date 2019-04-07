

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:swurdle_flutter_widgets/flutter_interface.dart';
import 'package:swurdle_flutter_widgets/game_screen.dart';
import 'package:swurdle_flutter_widgets/ui_widget.dart';
import 'package:swurdlelogic/swurdlelogic.dart';

class StartScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {


    return Container(
      color: Colors.blue,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          StartTopBar(),
          MiddleBar(),
          StartBottomBar(),
        ]

      ),
    );
  }


}

class StartTopBar extends StatelessWidget{
  @override
  Widget build(BuildContext context) {

    FlutterInterface ui= UI.of(context).ui;

    return Container(
      height: 50,

    );
  }


}

class MiddleBar extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Expanded(
      child: Container(
        color: Colors.brown,
      ),
    );
  }


}


class StartBottomBar extends StatelessWidget{
  @override
  Widget build(BuildContext context) {

    FlutterInterface ui= UI.of(context).ui;

    return Container(

      color: Colors.green,

      child: Row(

        children: <Widget>[

          Button(
              Icon(Icons.arrow_back),
                  (){
                ui.buttonSwap();
                ui.events.add(GameMessage(Event.reDraw));
              }

          ),
          Button(
              Icon(Icons.arrow_forward),
                  (){
                    ui.changeScreen.add(GameMessage(Event.goToGameScreen));
              }

          ),
          Button(
              Icon(Icons.help),
                  (){
                ui.newGame(Game.randomSize());


              }

          )

        ],
      ),
    );
  }


}
