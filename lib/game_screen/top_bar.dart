

import 'package:flutter/material.dart';
import 'package:swurdle_flutter_widgets/flutter_interface.dart';
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
