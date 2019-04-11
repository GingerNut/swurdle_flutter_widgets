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

class SpringBar extends StatelessWidget{

  Widget build(BuildContext context) {


   FlutterInterface ui = UI.of(context).ui;

    return StreamBuilder<GameMessage>(
      stream: ui.events.stream,
      builder: (context, snapshot) {

        List<Widget> springs = new List();

        Player player = ui.interfacePlayer;

        if(player.getSpring(ui.position) != null || (ui.move is TakeSpringMove)) springs.add(
          Container(
            height: 50,

            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Text(
                  'Springs',
                  style: TextStyle(
                    color: Colors.white,
                        fontSize: 30,
                  ),
                ),
              ),
            ),

          )
        );


        player.springs(ui.position).forEach((s) {

          if(s.tile == null) springs.add(SpringCard(ui.player));
        } );

        if(ui.move is TakeSpringMove) springs.add(SpringCard(ui.player));

        return Container(

          height: 50,

            color: Theme.of(context).primaryColor,

        child: Row(

          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,

          children: springs,

        )

        );
      }
    );
  }



}

class SpringCard extends StatelessWidget{
  final Player player;

  const SpringCard(this.player);

  Widget build(BuildContext context) {

    return Container(
      height: 50,
      width: 50,

      child: Padding(
        padding: const EdgeInsets.all(8.0),

        child: CustomPaint(
          painter: SpringPaint(player, UI.of(context).ui, 20),
        ),
      ),
    );
  }


}

class SpringPaint extends CustomPainter {

  final Player player;
  final FlutterInterface ui;
  final double springSize;

  SpringPaint(this.player, this.ui, this.springSize);

  @override
  void paint(Canvas canvas, Size size) {

    double blurSigma = 3.0;

    final shadowPaint = Paint()
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, blurSigma)
      ..color = Colors.black;

    var center = Offset(springSize * 0.6 , springSize * 0.6);

    canvas.drawCircle(center, springSize, shadowPaint);

    final paint = Paint();

    paint.color = ui.player == player ? FlutterInterface.getColor(player.color) : FlutterInterface.getColor(Board.COLOR_GREY);

    center = Offset(springSize * 0.5, springSize * 0.5);

    canvas.drawCircle(center, springSize, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
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
              Icon(Icons.alarm),
                  (){
                ui.move = PassMove(ui.player);
                ui.doMove();

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