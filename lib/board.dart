
import 'package:flutter/material.dart';
import 'package:swurdle_flutter_widgets/flutter_interface.dart';
import 'package:swurdle_flutter_widgets/letters_later.dart';
import 'package:swurdle_flutter_widgets/shadow_layer.dart';
import 'package:swurdle_flutter_widgets/tile_layer.dart';
import 'package:swurdle_flutter_widgets/ui_widget.dart';
import 'package:swurdle_flutter_widgets/words_layer.dart';


class FlutterBoard extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    FlutterInterface ui = UI
        .of(context)
        .ui;

    return Expanded(
      child: Container(
        color: Colors.lightGreenAccent,
        child: FittedBox(
          child: SizedBox(
            height: ui.verticalSize,
            width: ui.horizontalSize,

            child: Stack(

              children: [
                ShadowLayer(),
                TileLayer(),
                WordsLayer(),
                LettersLayer(),
              ],

            ),
          ),
        ),
      ),
    );
  }

}


