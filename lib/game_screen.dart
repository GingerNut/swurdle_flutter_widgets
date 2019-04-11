import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:swurdle_flutter_widgets/flutter_interface.dart';
import 'package:swurdle_flutter_widgets/ui_widget.dart';
import 'package:swurdlelogic/swurdlelogic.dart';
import 'board.dart';

class GameScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    //SystemChrome.setEnabledSystemUIOverlays([]);

    FlutterBoard board = FlutterBoard();
    TopBar topBar = TopBar();
    BottomBar bottomBar = BottomBar();

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

class TopBar extends StatelessWidget{
  @override
  Widget build(BuildContext context) {

    FlutterInterface ui= UI.of(context).ui;

   List<Scorecard> scores = new List();
   ui.game.players.forEach((p) => scores.add(Scorecard(p)));

    return SafeArea(

      child: StreamBuilder<GameMessage>(
        stream: ui.events.stream,
        builder: (context, snapshot) {

          return Container(

            color: Theme.of(context).primaryColor,

            height: 50,

            child: Row(

              children: scores,

            ),
          );
        }
      ),
    );
  }


}

class Scorecard extends StatelessWidget{

  final Player player;

  const Scorecard(this.player);

  Widget build(BuildContext context) {

    FlutterInterface ui = UI.of(context).ui;

        return Expanded(
          child: Padding(

            padding: const EdgeInsets.all(4.0),

            child: ClipRRect(

              borderRadius: BorderRadius.circular(40.0),

              child: Container(

                child: FittedBox(
                  child: StreamBuilder<GameMessage>(
                    stream: ui.events.stream,
                    builder: (context, snapshot) {
                      return Text (
                        player.score(ui.position).toString(),
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      );
                    }
                  ),
                ),

                decoration: new BoxDecoration(

                  color: FlutterInterface.getColor(player.color),

                  boxShadow: <BoxShadow>[
                    BoxShadow (
                      color: Colors.black,
                      offset: new Offset(0.0, 30.0),
                      blurRadius: 40.0,
                    ),
                  ],

                ),



      ),
            ),
          ),
        );
      

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
              }

          ),
          Button(
              Icon(Icons.arrow_forward),
                  (){
                    ui.changeScreen.add(GameMessage(Event.goToStartScreen));
              }

          ),
          Button(
              Icon(Icons.help),
              (){
               ui.newGame(Game.randomSize());

               ui.events.add(GameMessage(Event.newGame));
              }

          )

        ],
      ),
    );
  }


}


class Button extends StatelessWidget{

  final Icon icon;
  final Function onPressed;

  Button(this.icon, this.onPressed);
  
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return  Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(80.0),
          child: RaisedButton(
            color: Theme.of(context).accentColor,
            onPressed: onPressed,
            child: icon,
          ),
        ),
      ),
    );
  }


}