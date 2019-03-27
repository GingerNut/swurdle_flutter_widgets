

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:swurdle_flutter_widgets/flutter_interface.dart';
import 'package:swurdle_flutter_widgets/game_screen.dart';
import 'package:swurdlelogic/swurdlelogic.dart';

main() {

  FlutterInterface ui = new FlutterInterface();

  Game game = new Game(ui);

  ui.game = game;

  game.newGame(7);


  runApp(MyApp(ui));
}



class MyApp extends StatelessWidget {

  final FlutterInterface ui;

  MyApp(this.ui);


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Row & Column Example',
      theme: ThemeData(
        primaryColor: Color(0xFF43a047),
        accentColor: Color(0xFFffcc00),
        primaryColorBrightness: Brightness.dark,
      ),
      home: GameScreen(ui),
    );
  }
}