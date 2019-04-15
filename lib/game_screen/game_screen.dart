import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:swurdle_flutter_widgets/game_screen/board.dart';
import 'package:swurdle_flutter_widgets/flutter_interface.dart';
import 'package:swurdle_flutter_widgets/game_screen/spring_bar.dart';
import 'package:swurdle_flutter_widgets/game_screen/top_bar.dart';
import 'package:swurdle_flutter_widgets/ui_widget.dart';
import 'dart:async';

import 'package:swurdlelogic/swurdlelogic.dart';


class GameScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    //SystemChrome.setEnabledSystemUIOverlays([]);

    FlutterBoard board = FlutterBoard();
    TopBar topBar = TopBar();
    BottomBar bottomBar = BottomBar();
    SpringBar springBar = SpringBar();

    return StreamBuilder<GameMessage>(
      stream: UI.of(context).ui.events.stream,
      builder: (context, snapshot) {

       if(snapshot?.data?.event == Event.newGame) board = FlutterBoard();

       return Column(

         crossAxisAlignment: CrossAxisAlignment.stretch,
         mainAxisSize: MainAxisSize.min,
         children: <Widget>[
           topBar,
           board,
           springBar,
           bottomBar,
         ],
       );

      }
    );
  }

  dispose(){
    //SystemChrome.restoreSystemUIOverlays();
  }

}




class BottomBar extends StatelessWidget{
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
              },
             Theme.of(context).accentColor,

          ),
         DoMoveButton(),

          DoPassButton(),


          Button(
              Icon(Icons.help),
              (){
               ui.newGame(SwurdleGame.randomSize());

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

class DoMoveButton extends StatefulWidget{

  @override
  _DoMoveButtonState createState() => _DoMoveButtonState();
}

class _DoMoveButtonState extends State<DoMoveButton> {
  bool OK = true;

  @override
  Widget build(BuildContext context) {



    FlutterInterface ui = UI.of(context).ui;


    return  Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(80.0),
          child: RaisedButton(
            color: OK ? Theme.of(context).accentColor : FlutterInterface.getColor(Board.COLOR_GREY),
            onPressed: () async{
              ui.doMove();

              OK = false;

              ui.events.add(GameMessage(Event.reDraw));

              Timer(Duration(milliseconds: 1000), () {

                OK = true;

                ui.events.add(GameMessage(Event.reDraw));
              });

            },
            child: Icon(
              Icons.play_arrow,
            ),
          ),
        ),
      ),
    );
  }
}

class DoPassButton extends StatefulWidget{

  @override
  _DoPassButtonState createState() => _DoPassButtonState();
}

class _DoPassButtonState extends State<DoPassButton> {
  bool OK = true;

  @override
  Widget build(BuildContext context) {

    FlutterInterface ui = UI.of(context).ui;

    return  Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(80.0),
          child: RaisedButton(
            color: OK ? Theme.of(context).accentColor : FlutterInterface.getColor(Board.COLOR_GREY),
            onPressed: () async{
              ui.pass();

              OK = false;

              ui.events.add(GameMessage(Event.reDraw));

              Timer(Duration(milliseconds: 1000), () {

                OK = true;

                ui.events.add(GameMessage(Event.reDraw));
              });

            },
            child: Icon(
              Icons.gavel,
            ),
          ),
        ),
      ),
    );
  }
}



class Button extends StatelessWidget{

  final Icon icon;
  final Function onPressed;
  final Color color;

  Button(this.icon, this.onPressed, this.color);
  
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return  Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(80.0),
          child: RaisedButton(
            color: color,
            onPressed: onPressed,
            child: icon,
          ),
        ),
      ),
    );
  }


}