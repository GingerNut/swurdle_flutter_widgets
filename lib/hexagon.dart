
import 'package:flutter/material.dart';
import 'package:swurdle_flutter_widgets/flutter_interface.dart';
import 'package:swurdle_flutter_widgets/ui_widget.dart';
import 'package:swurdlelogic/swurdlelogic.dart';

class FlutterHexagon extends StatefulWidget{

  final Tile tile;

  FlutterHexagon(this.tile);

  @override
  HexState createState() => HexState(tile);

}

class HexState extends State<FlutterHexagon>{

  final Tile tile;

  HexState(this.tile);

  @override
  Widget build(BuildContext context) {

    FlutterInterface ui = UI.of(context).ui;
    HexModel model = ui.model(tile);

    return StreamBuilder<GameMessage>(
      stream: ui.events.stream,
      builder: (context, snapshot) {

        return Positioned(
          left: model.homeX,
          top: model.homeY,

          child: Container(

            child: SizedBox(
              height: model.hexSize,
              width: model.hexSize,
              child: GestureDetector(

                onTapUp: (d){
                  setState(() {
                    ui.select(model.tile);

                  });
                },

                onPanDown: (d){

                },

                onPanUpdate: (d){

                  setState(() {
                    model.homeX = d.globalPosition.dx;
                    model.homeY = d.globalPosition.dy;

                    Tile t = ui.getTile(model.homeX, model.homeY);

                    if(t != null) {
                      ui.holding1 = t;

                    }

                  });

                },

                onPanEnd: (d){

                  model.setVariables();

                  ui.holding2 = model.tile;

                  if(ui.holding1 != null && ui.holding2 != null && ui.holding1.k != ui.holding2.k){
                    ui.buttonSwap();
                  } else {

                  }

                },

                child: StreamBuilder<GameMessage>(
                  stream: ui.events.stream,
                  builder: (context, snapshot) {
                    return CustomPaint(
                      painter: HexagonPaint(model),

                      child: FittedBox(
                        child: Text(
                            ui.position.wordOwnerBoard != null && ui.position.wordOwnerBoard[model.tile.k] != null ?  '' : ui.letters[model.tile.k],
                            style: TextStyle(
                              color: Colors.black
                            ),
                          ),
                      ),
                    );
                  }
                ),
              ),
            ),
          ),
        );
      }
    );
  }






}

class HexagonPaint extends CustomPainter {
  
  final HexModel model;

  HexagonPaint(this.model);
  
  @override
  void paint(Canvas canvas, Size size) {

    final paint = Paint();

    paint.color = model.ui.getColor(model.tile.color);

    // center of the canvas is (x,y) => (width/2, height/2)
    var center = Offset(model.hexSize/2, model.hexSize/2);

    canvas.drawCircle(center, model.hexSize/1.8, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }


}

