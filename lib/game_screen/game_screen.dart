import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:swurdle_flutter_widgets/game_screen/board.dart';
import 'package:swurdle_flutter_widgets/flutter_interface.dart';
import 'package:swurdle_flutter_widgets/game_screen/spring_bar.dart';
import 'package:swurdle_flutter_widgets/ui_widget.dart';
import 'package:swurdlelogic/swurdlelogic.dart';


class GameScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    //SystemChrome.setEnabledSystemUIOverlays([]);

    FlutterBoard board = FlutterBoard();
    TopBar topBar = TopBar();
    StatusBar statusBar = StatusBar();
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
           statusBar,
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

class TopBar extends StatelessWidget{
  @override
  Widget build(BuildContext context) {

   FlutterInterface ui = UI.of(context).ui;

    return SafeArea(

      child: StreamBuilder<GameMessage>(

        stream: ui.events.stream,
        builder: (context, snapshot) {

          List<Scorecard> scores = new List();
          ui.game.players.forEach((p) => scores.add(Scorecard(p)));

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

              child: StreamBuilder<GameMessage>(
                stream: ui.events.stream,
                builder: (context, snapshot) {
                  return Container(

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

                      color: player == ui.position.player ? FlutterInterface.getColor(player.color) : FlutterInterface.getColor(Board.COLOR_GREY),

                      boxShadow: <BoxShadow>[
                        BoxShadow (
                          color: Colors.black,
                          offset: new Offset(0.0, 30.0),
                          blurRadius: 40.0,
                        ),
                      ],

                    ),



      );
                }
              ),
            ),
          ),
        );
      

  }



}

class StatusBar extends StatelessWidget {

  Widget build(BuildContext context) {
    FlutterInterface ui = UI
        .of(context)
        .ui;


    return StreamBuilder<GameMessage>(
        stream: ui.events.stream,
        builder: (context, snapshot) {

          List<StatusCard> statusCards = new List();
          ui.game.players.forEach((p) => statusCards.add(StatusCard(p)));

          return Container(

            color: Theme
                .of(context)
                .primaryColor,

            height: 50,

            child: Row(

              children: statusCards,

            ),
          );
        }
    );
  }
}

class StatusCard extends StatelessWidget{

  final Player player;

  const StatusCard(this.player);

  Widget build(BuildContext context) {

    FlutterInterface ui = UI.of(context).ui;

    return StreamBuilder<Object>(
      stream: ui.events.stream,
      builder: (context, snapshot) {

        List<Widget> springs = new List();

        springs.add(Expanded(
          child: Container(),
        ));

        player.springs(ui.position).forEach((s) {

          if(s.tile == null) springs.add(
              SizedBox(
                height: 30,
                width: 30,

                child: CustomPaint(
                  painter: SpringPaint(player, UI.of(context).ui, 10),
                ),
              )
          );

        });

        springs.add(Expanded(
          child: Container(),
        ));

        return Expanded(
          child: Row(


            children: springs
          ),
        );
      }
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