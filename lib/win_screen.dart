import 'dart:ui';

import 'package:flutter/material.dart';
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
    BottomBar bottomBar = BottomBar();


    return StreamBuilder<GameMessage>(
        stream: UI.of(context).ui.events.stream,
        builder: (context, snapshot) {

          if(snapshot?.data?.event == Event.newGame) board = FlutterBoard();

          return Stack(


            children: [
              BackdropFilter(

                filter: ImageFilter.blur(
                  sigmaX: 20,
                  sigmaY: 20,
                ),

                child: Container(
                  color: Colors.black.withOpacity(0),
                  
                  child: Column( 
                    children:<Widget>[

                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              color: Theme.of(context).primaryColor,
                            height: 100,
                        ),
                          )
                        ]
                      ),

                    board,
                    bottomBar,
                    ]

                      ),
                ),
              ),

            Center(
                child: topBar)

            ]
          );

        });

  }
}