
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

                      child: GestureDetector(

                        onTapUp: (d){

                          ui.select(tile);

                        },

                        onPanDown: (d){

                        },

                        onPanUpdate: (d){

                          tile.homeX = d.globalPosition.dx;
                          tile.homeY = d.globalPosition.dy;

                          Tile t = ui.getTile(tile.homeX, tile.homeY);

                          if(t != null) {
                            ui.holding1 = t;
                            ui.events.add(GameMessage(Event.reDraw));

                          }

                        },

                        onPanEnd: (d){

                          tile.setVariables();

                          ui.holding2 = tile;

                          if(ui.holding1 != null && ui.holding2 != null && ui.holding1.k != ui.holding2.k){
                            ui.buttonSwap();
                          } else {

                          }

                        },

                        child: FittedBox(
                          child: Text(
                            ui.position.wordOwnerBoard != null && ui.position.wordOwnerBoard[tile.k] != null ?  '' : ui.letters[tile.k],
                            style: TextStyle(
                                color: Colors.black
                            ),
                          ),
                        ),
                      ),
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

    canvas.drawCircle(center, tile.hexSize/1.8, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }


}

