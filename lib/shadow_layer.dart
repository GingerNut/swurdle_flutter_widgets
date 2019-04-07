


import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:swurdle_flutter_widgets/flutter_interface.dart';
import 'package:swurdle_flutter_widgets/ui_widget.dart';
import 'package:swurdlelogic/swurdlelogic.dart';

class ShadowLayer extends StatelessWidget{

  final List<Widget> pieces = new List();

  Widget build(BuildContext context) {

    FlutterInterface ui = UI.of(context).ui;

    ui.tiles.forEach((t) {
      pieces.add(Shadow(t));
    });

    return Opacity(
      opacity: 0.8,

      child: Stack(

        children: pieces,

      ),
    );
  }





}

class Shadow extends StatelessWidget{

  final Tile tile;

  const Shadow(this.tile);

  @override
  Widget build(BuildContext context) {

    return CustomPaint(

      painter: ShadowPainter(tile),

    );
  }

}

class ShadowPainter extends CustomPainter{

  final Tile tile;

  ShadowPainter(this.tile);

  @override
  void paint(Canvas canvas, Size size) {

    double s = tile.hexSize;
    double blurSigma = 3.0;

    final paint = Paint()
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, blurSigma)
      ..color = Colors.black;

    var center = Offset(tile.homeX + s/1.8, tile.homeY + s/1.8);

    canvas.drawCircle(center, s/1.8, paint);

  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {

    return true;
  }


}