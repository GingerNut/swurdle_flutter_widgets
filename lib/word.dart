

import 'package:flutter/widgets.dart';
import 'package:swurdle_flutter_widgets/flutter_interface.dart';
import 'package:swurdle_flutter_widgets/ui_widget.dart';
import 'package:swurdlelogic/swurdlelogic.dart';

class FlutterWord extends StatefulWidget{
  final Word word;

  FlutterWord(this.word);


  _FlutterWordState createState() => _FlutterWordState(word);
}

class _FlutterWordState extends State<FlutterWord> {

  Word word;

  _FlutterWordState(this.word);

  Widget build(BuildContext context) {

    FlutterInterface ui = UI.of(context).ui;


    return SizedBox(
      height: ui.verticalSize,
      width: ui.horizontalSize,

      child: WordPainter(word),

    );
  }
}

class WordPainter extends CustomPaint{

  final Word word;

  WordPainter(this.word);

  void paint(Canvas canvas, Size size) {
    var rect = Offset.zero & size;
    var gradient = RadialGradient(
      center: const Alignment(0.7, -0.6),
      radius: 0.2,
      colors: [const Color(0xFFFFFF00), const Color(0xFF0099FF)],
      stops: [0.4, 1.0],
    );
    canvas.drawRect(
      rect,
      Paint()..shader = gradient.createShader(rect),
    );
  }

}