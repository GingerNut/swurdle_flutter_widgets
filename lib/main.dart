

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:swurdle_flutter_widgets/flutter_interface.dart';
import 'package:swurdle_flutter_widgets/game_screen.dart';
import 'package:swurdle_flutter_widgets/start_screen.dart';
import 'package:swurdle_flutter_widgets/ui_widget.dart';
import 'package:swurdlelogic/swurdlelogic.dart';



main() async{

  FlutterInterface ui = new FlutterInterface();
  Game game = new Game(ui);
  ui.game = game;

  await game.setUp();

  game.newGame(9);

  runApp(MyApp(ui));
}



class MyApp extends StatelessWidget {

  final FlutterInterface ui;

  const MyApp(this.ui);

  @override
  Widget build(BuildContext context) {

    SystemChrome.restoreSystemUIOverlays();

    GameScreen gameScreen = GameScreen();
    StartScreen startScreen = StartScreen();
    Widget screen = startScreen;

    return MaterialApp(
      title: 'Swurdle',
      theme: ThemeData(
        primaryColor: Color(0xFF43a047),
        accentColor: Color(0xFFffcc00),
        primaryColorBrightness: Brightness.dark,
      ),
      home: Material(
        child: UI(
          ui: ui,

            child: StreamBuilder<GameMessage>(
              stream: ui.changeScreen.stream,
              builder: (context, snapshot) {

                if(snapshot?.data?.event == Event.goToGameScreen) screen = gameScreen;
                else if(snapshot?.data?.event == Event.goToStartScreen) screen = startScreen;

                return screen;
              }
            )
        ),
      ),
    );
  }

  dispose(){
    SystemChrome.restoreSystemUIOverlays();
  }
}


