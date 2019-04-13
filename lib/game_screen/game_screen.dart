import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:swurdle_flutter_widgets/game_screen/board.dart';
import 'package:swurdle_flutter_widgets/flutter_interface.dart';
import 'package:swurdle_flutter_widgets/game_screen/spring_bar.dart';
import 'package:swurdle_flutter_widgets/game_screen/top_bar.dart';
import 'package:swurdle_flutter_widgets/ui_widget.dart';
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
          Button(
              Icon(Icons.arrow_forward),
                  (){
                    ui.changeScreen.add(GameMessage(Event.goToStartScreen));
              },
            Theme.of(context).accentColor,

          ),

                StreamBuilder<GameMessage>(
                  stream: ui.events.stream,
                  builder: (context, snapshot) {

                    return Button(
                        Icon(Icons.alarm),
                            (){
                          if(ui.doMoveSafe)ui.move = PassMove(ui.player);
                          if(ui.doMoveSafe) ui.doMove();

                        },
                      ui.doMoveSafe ? Theme.of(context).accentColor : FlutterInterface.getColor(Board.COLOR_GREY),

                    );
                  }
                ),



          Button(
              Icon(Icons.help),
              (){
               ui.newGame(Game.randomSize());

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