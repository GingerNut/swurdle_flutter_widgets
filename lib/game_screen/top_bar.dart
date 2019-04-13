

import 'package:flutter/material.dart';
import 'package:swurdle_flutter_widgets/flutter_interface.dart';
import 'package:swurdle_flutter_widgets/game_screen/game_screen.dart';
import 'package:swurdle_flutter_widgets/game_screen/spring_bar.dart';
import 'package:swurdle_flutter_widgets/ui_widget.dart';
import 'package:swurdlelogic/swurdlelogic.dart';

class TopBar extends StatelessWidget{
  @override
  Widget build(BuildContext context) {

    FlutterInterface ui = UI.of(context).ui;

    return SafeArea(

      child: StreamBuilder<GameMessage>(

          stream: ui.events.stream,
          builder: (context, snapshot) {

            List<Scorecard> scores = new List();
            ui.game.players.forEach((p) {

              if(p.status(ui.position) != PlayerStatus.out) scores.add(Scorecard(p));
            } );

            List<Widget> column = new List();

            column.add(
                Expanded(
              child: Row(
                children: scores,
              ),
            ));

            return Hero(
              tag: 'score',

              child: Container(

                color: Theme.of(context).primaryColor,

                height: ui.game.gameOver ? 400 : 50,

                child: Column(
                  children: column,
                )
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

                Color color = player == ui.position.player ? FlutterInterface.getColor(player.color) : FlutterInterface.getColor(Board.COLOR_GREY);

                if(ui.game.gameOver) color = FlutterInterface.getColor(player.color);

                List<Widget> column = new List();

                if(ui.game.gameOver) column.add(
                  Text(
                    'Winner !',
                    style: TextStyle(
                      color: Colors.white,
                    ),

                  )
                );

                column.add(Text (
                  player.score(ui.position).toString(),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 40,
                  ),
                ),);

                column.add(StatusCard(player));


                return Container(

                  child: FittedBox(
                    child: StreamBuilder<GameMessage>(
                        stream: ui.events.stream,
                        builder: (context, snapshot) {



                          return Column(
                            children: column,
                          );
                        }
                    ),
                  ),

                  decoration: new BoxDecoration(

                    color: color,

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

class StatusCard extends StatelessWidget{

  final Player player;

  const StatusCard(this.player);

  Widget build(BuildContext context) {

    FlutterInterface ui = UI.of(context).ui;

    return StreamBuilder<Object>(
        stream: ui.events.stream,
        builder: (context, snapshot) {

          List<Widget> springs = new List();


          player.springs(ui.position).forEach((s) {

            if(s.tile == null) springs.add(
                SizedBox(
                  height: 30,
                  width: 30,

                  child: Icon(
                    Icons.add_circle,
                    color: Colors.white,
                  ),
                )
            );

          });

          if(player.passes == 1) springs.add(Icon(
            Icons.gavel,
            color: Colors.white,
          ));

          springs.add(Timer(player,50));


          return Row(
              children: springs
          );
        }
    );
  }



}
