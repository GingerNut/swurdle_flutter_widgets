

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:swurdle_flutter_widgets/flutter_interface.dart';
import 'package:swurdle_flutter_widgets/hexagon.dart';
import 'package:swurdle_flutter_widgets/ui_widget.dart';
import 'package:swurdlelogic/swurdlelogic.dart';

class WordsLayer extends StatelessWidget{

  Widget build(BuildContext context) {

    FlutterInterface ui = UI.of(context).ui;

    return CustomPaint(
        painter: WordPainter(ui),
    );
  }
}

class WordPainter extends CustomPainter {

  final FlutterInterface ui;

  WordPainter(this.ui);

  @override
  void paint(Canvas canvas, Size size) {

    ui.position.words.words.forEach((w){

      double size = ui.model(w.first).hexSize;

      final paint = Paint()
        ..strokeWidth = size/2
        ..color = ui.getColor(w.color);

      var center = Offset(ui.model(w.first).homeX + size/2, ui.model(w.first).homeY + size/2);

      canvas.drawCircle(center, size/2, paint);

      for(int i = 0 ; i < w.length - 1; i ++){
        HexModel start = ui.model(w.tiles[i]);
        HexModel end = ui.model(w.tiles[i+1]);

        canvas.drawCircle(Offset(end.homeX + size/2, end.homeY + size/2), size/4, paint);

        canvas.drawLine(Offset(start.homeX + size/2, start.homeY + size/2), Offset(end.homeX + size/2, end.homeY + size/2), paint);
      }

      w.tiles.forEach((t){

        paintLetter(canvas, size, t);

      });



    });


  }

  paintLetter(Canvas canvas, double size, Tile t){
    var center = Offset(ui.model(t).homeX + size * .3, ui.model(t).homeY + size * .25);

    TextSpan span = TextSpan(
        style: new TextStyle(
            fontSize: size/2,
            color: Colors.white

        ),

        text: ui.letters[t.k]);

    TextPainter tp = TextPainter()
      .. text = span
      ..textDirection = TextDirection.ltr
      ..textAlign = TextAlign.center;

    tp.layout();
    tp.paint(canvas,center);


  }



  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }


}

