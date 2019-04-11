
import 'package:flutter/material.dart';
import 'package:swurdle_flutter_widgets/flutter_interface.dart';
import 'package:swurdle_flutter_widgets/ui_widget.dart';
import 'package:swurdlelogic/swurdlelogic.dart';

class FlutterHexagon extends StatelessWidget{

  final Tile tile;

  FlutterHexagon(this.tile);

  @override
  Widget build(BuildContext context) {

    FlutterInterface ui = UI.of(context).ui;

    return StreamBuilder<GameMessage>(
        stream: ui.events.stream,
        builder: (context, snapshot) {

          return Positioned(
            left: tile.homeX,
            top: tile.homeY,

            child: Container(
              height: tile.hexSize,
              width: tile.hexSize,

              child: StreamBuilder<GameMessage>(
                  stream: ui.events.stream,
                  builder: (context, snapshot) {
                    return CustomPaint(
                      painter: HexagonPaint(tile),


                    );
                  }
              ),
            ),
          );
        }
    );
  }

}


class HexagonPaint extends CustomPainter {

  final Tile tile;

  HexagonPaint(this.tile);
  
  @override
  void paint(Canvas canvas, Size size) {

    final paint = Paint();

   paint.color = FlutterInterface.getColor(tile.color);

    var center = Offset(tile.hexSize/2, tile.hexSize/2);

    if(tile.letter != ' ') canvas.drawCircle(center, tile.hexSize/1.8, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }


}

