

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:swurdle_flutter_widgets/flutter_interface.dart';
import 'package:swurdle_flutter_widgets/game_screen/game_screen.dart';
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

    return Container(
      color: Theme.of(context).primaryColor,

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
        color: Theme.of(context).primaryColor,
      ),
    );
  }


}


class StartBottomBar extends StatelessWidget{
  @override
  Widget build(BuildContext context) {

    FlutterInterface ui= UI.of(context).ui;

    return Container(

      color: Theme.of(context).primaryColor,

      child: Row(

        children: <Widget>[

          Button(
              Icon(Icons.arrow_back),
                  (){
                ui.doMove();
                ui.events.add(GameMessage(Event.reDraw));
              },
             Theme.of(context).accentColor,

          ),
          Button(
              Icon(Icons.arrow_forward),
                  (){

              },
            Theme.of(context).accentColor,

          ),
          Button(
              Icon(Icons.help),
                  () async{
                await ui.newGame(SwurdleGame.randomSize());
                ui.events.add(GameMessage(Event.newGame));
                ui.changeScreen.add(GameMessage(Event.goToGameScreen));

              },
            Theme.of(context).accentColor,

          )

        ],
      ),
    );
  }


}
