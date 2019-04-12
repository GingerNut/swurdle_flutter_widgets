
import 'package:flutter/material.dart';
import 'package:swurdle_flutter_widgets/flutter_interface.dart';
import 'package:swurdle_flutter_widgets/game_screen/letters_later.dart';
import 'package:swurdle_flutter_widgets/game_screen/shadow_layer.dart';
import 'package:swurdle_flutter_widgets/game_screen/tile_layer.dart';
import 'package:swurdle_flutter_widgets/ui_widget.dart';
import 'package:swurdle_flutter_widgets/game_screen/words_layer.dart';


class FlutterBoard extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    FlutterInterface ui = UI
        .of(context)
        .ui;

    return Expanded(
      child: Container(
        color: Theme.of(context).primaryColor,
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


