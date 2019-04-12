

import 'package:flutter/widgets.dart';
import 'package:swurdle_flutter_widgets/game_screen/board.dart';
import 'package:swurdle_flutter_widgets/game_screen/game_screen.dart';
import 'package:swurdle_flutter_widgets/game_screen/spring_bar.dart';
import 'package:swurdle_flutter_widgets/game_screen/top_bar.dart';
import 'package:swurdle_flutter_widgets/ui_widget.dart';
import 'package:swurdlelogic/swurdlelogic.dart';

class WinScreen extends StatelessWidget{

  Widget build(BuildContext context) {

    FlutterBoard board = FlutterBoard();
    TopBar topBar = TopBar();
    StatusBar statusBar = StatusBar();
    BottomBar bottomBar = BottomBar();
    SpringBar springBar = SpringBar();

    return StreamBuilder<GameMessage>(
        stream: UI.of(context).ui.events.stream,
    builder: (context, snapshot) {

    if(snapshot?.data?.event == Event.newGame) board = FlutterBoard();

    return Column(
      children:<Widget>[topBar,
             board,
             bottomBar,
      ]

    );

    });

  }
}
