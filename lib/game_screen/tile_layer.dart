


import 'package:flutter/widgets.dart';
import 'package:swurdle_flutter_widgets/flutter_interface.dart';
import 'package:swurdle_flutter_widgets/game_screen/hexagon.dart';
import 'package:swurdle_flutter_widgets/ui_widget.dart';
import 'package:swurdlelogic/swurdlelogic.dart';

class TileLayer extends StatelessWidget{

  final List<Widget> pieces = new List();

  Widget build(BuildContext context) {

    FlutterInterface ui = UI.of(context).ui;

    return StreamBuilder<GameMessage>(
      stream: ui.events.stream,
      builder: (context, snapshot) {

        pieces.clear();

        ui.tiles.forEach((t) {
          pieces.add(FlutterHexagon(t));
        });


        return Stack(

          children: pieces,

        );
      }
    );
  }





}