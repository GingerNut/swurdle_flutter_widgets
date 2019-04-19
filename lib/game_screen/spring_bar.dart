

import 'package:flutter/material.dart';
import 'package:swurdle_flutter_widgets/flutter_interface.dart';
import 'package:swurdle_flutter_widgets/ui_widget.dart';
import 'package:swurdlelogic/swurdlelogic.dart';

class SpringBar extends StatelessWidget{

  Widget build(BuildContext context) {


    FlutterInterface ui = UI.of(context).ui;

    return StreamBuilder<GameMessage>(
        stream: ui.events.stream,
        builder: (context, snapshot) {

          List<Widget> springs = new List();

          Player player = ui.interfacePlayer;

          if(ui.position.getSpring(player) != null || (ui.move is TakeSpringMove)) springs.add(
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


          ui.position.freeSprings(player).forEach((s) {

            springs.add(SpringCard(ui.player));
          } );

          if(ui.move is TakeSpringMove) springs.add(SpringCard(ui.player));

          springs.add(
              Expanded(
                  child: Container(

                  )));

          if(ui.position.passes[ui.interfacePlayer.number] == 1){



            springs.add(
               PassWarning()
            );

            springs.add(Container(
              width: 40,

            ));
          }

          if(ui.game.settings.timer) springs.add(TimerCard(ui.interfacePlayer, 50));

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

    paint.color = ui.player == player ? FlutterInterface.getColor(player.color) : FlutterInterface.getColor(Palette.COLOR_GREY);

    center = Offset(springSize * 0.5, springSize * 0.5);

    canvas.drawCircle(center, springSize, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }


}

class PassWarning extends StatelessWidget{

  @override
  Widget build(BuildContext context) {

    return  Container(
      height: 50,
      width: 50,
      child: FittedBox(
        child: Center(
          child: Icon(
            Icons.gavel,
            color: Colors.black,
          ),

        ),
      ),
    );
  }}

class TimerCard extends StatelessWidget{

  final Player player;
  final double height;

  const TimerCard(this.player, this.height);

  @override
  Widget build(BuildContext context) {

    return StreamBuilder<TimeStamp>(
      stream: player.timer.events.stream,
      builder: (context, snapshot) {

        String string = 'timer ';

        if(snapshot != null){

          string = snapshot.data == null ? 'timer' : snapshot.data.display;

          if(player.timeLeft < 0.1) string = 'OUT ';
        }
;
        return Container(
          height: height,
          
          child: Center(
            child: Text(
              string,
              style: TextStyle(
                color: FlutterInterface.getColor(Palette.colorCombo(player.color)),
                    fontSize: height /2,
              ),
            ),
          ),
        );
      }
    );;
  }


}