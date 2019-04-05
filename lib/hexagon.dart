
import 'package:flutter/material.dart';
import 'package:swurdle_flutter_widgets/flutter_interface.dart';
import 'package:swurdle_flutter_widgets/ui_widget.dart';
import 'package:swurdlelogic/swurdlelogic.dart';

class FlutterHexagon extends StatefulWidget{

  final Tile tile;
  final FlutterInterface ui;
  final HexModel model;

  FlutterHexagon(this.tile, this.ui, this.model);

  @override
  HexState createState() => HexState(model, ui);


}


class HexModel{

  final FlutterInterface ui;
  final Tile tile;

  double hexSize;
  double homeX;
  double homeY;

  double minX;
  double maxX;
  double minY;
  double maxY;

  HexModel(this.ui, this.tile){
    setVariables();
  }

  setVariables(){

    hexSize = ui.smallDimension / ui.game.size * 0.75;

    double hexagonSpacingVertical = hexSize * 1.2;
    double hexagonSpacingHorizontal = hexSize * 1.2;

    homeX = tile.i * hexagonSpacingHorizontal + hexagonSpacingHorizontal/2 ;
    homeY = tile.j * hexagonSpacingVertical + hexagonSpacingVertical/2 ;
    if(tile.i.isEven) homeY += hexagonSpacingVertical/2;

    minX = homeX - hexSize/2;
    maxX = homeX + hexSize/2;
    minY = homeY - hexSize/2;
    maxY = homeY + hexSize/2;

  }

  bool contains(Offset offset)=> (offset.dx > minX && offset.dx < maxX &&  offset.dy > minY && offset.dy < maxY);
}

class HexState extends State<FlutterHexagon>{

  final FlutterInterface ui;
  final HexModel model;
  Color color;

  HexState(this.model, this.ui){

    color = ui.getColor(model.tile.color);
  }

  @override
  Widget build(BuildContext context) {

    String letter = ui.letters[model.tile.k];

    if(ui.position.wordOwnerBoard != null){
      if(ui.position.wordOwnerBoard[model.tile.k] != null) letter = '';
    }

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

                UI.of(context).events.add(GameState()..valid = false);
              });
            },

            onPanDown: (d){
              ui.holding1 = model.tile;
              UI.of(context).events.add(GameState()..valid = false);
            },

            onPanUpdate: (d){

              setState(() {
                model.homeX = d.globalPosition.dx;
                model.homeY = d.globalPosition.dy;

                Tile t = ui.getTile(Offset(model.homeX, model.homeY));

                if(t != null) {
                  ui.holding2 = t;
                  UI.of(context).events.add(GameState()..valid = false);
                }

              });



            },

            onPanEnd: (d){

              model.setVariables();

              ui.buttonSwap();
              UI.of(context).events.add(GameState()..valid = false);

            },

            child: CustomPaint(
              painter: HexagonPaint(model),

              child: FittedBox(
                child: Text(
                      letter,
                    style: TextStyle(
                      color: Colors.black
                    ),
                  ),
              ),
            ),
          ),
        ),
      ),
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

