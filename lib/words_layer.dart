
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:swurdle_flutter_widgets/flutter_interface.dart';
import 'package:swurdle_flutter_widgets/ui_widget.dart';
import 'package:swurdlelogic/swurdlelogic.dart';

class WordsLayer extends StatelessWidget{

  Widget build(BuildContext context) {

    FlutterInterface ui = UI.of(context).ui;

    return IgnorePointer(
      child: CustomPaint(
        painter: WordPainter(ui),


      ),
    );
  }
}

class WordPainter extends CustomPainter {

  final FlutterInterface ui;

  WordPainter(this.ui);

  @override
  void paint(Canvas canvas, Size size) {

    ui.position.words.words.forEach((w){

      double size = w.first.hexSize;
      final double wordSize = size * 0.6;
      final double firstLetterSize = size * 0.8;

      final paint = Paint()
        ..strokeWidth = wordSize
        ..color = FlutterInterface.getColor(w.color);

      var center = Offset(w.first.homeX + size/2, w.first.homeY + size/2);

      canvas.drawCircle(center, firstLetterSize/2, paint);

      for(int i = 0 ; i < w.length - 1; i ++){
        Tile start = w.tiles[i];
        Tile end = w.tiles[i+1];

        canvas.drawCircle(Offset(end.homeX + size/2, end.homeY + size/2), wordSize/2, paint);

        canvas.drawLine(Offset(start.homeX + size/2, start.homeY + size/2), Offset(end.homeX + size/2, end.homeY + size/2), paint);
      }


    });


  }



  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }


}

