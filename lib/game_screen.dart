import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:swurdle_flutter_widgets/flutter_interface.dart';
import 'package:swurdle_flutter_widgets/ui_widget.dart';
import 'board.dart';
import 'package:swurdlelogic/swurdlelogic.dart';

class GameScreen extends StatelessWidget {

  final FlutterInterface ui;

  const GameScreen(this.ui);



  @override
  Widget build(BuildContext context) {

    return MaterialApp(

        theme: ThemeData(
          // Define the default Brightness and Colors
          brightness: Brightness.dark,
          primaryColor: Colors.lightGreen[800],
          accentColor: Colors.cyan[600],

          // Define the default Font Family
          fontFamily: 'Montserrat',

          // Define the default TextTheme. Use this to specify the default
          // text styling for headlines, titles, bodies of text, and more.
          textTheme: TextTheme(
            headline: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
            title: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
            body1: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
          ),
        ),


      home:  Scaffold(

        body: Body(ui),
      ),
    );
  }


}



class Body extends StatelessWidget{

  final FlutterInterface ui;

  const Body(this.ui);


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      // This makes each child fill the full width of the screen
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        TopBar(),
        FlutterBoard(ui),
        BottomBar(),
      ],
    );
  }

}

class TopBar extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SafeArea(
      child: Container(

        color: Colors.green,

        child: Row(

          children: <Widget>[

            Button(
                Icon(Icons.arrow_back),
                    (){
                  print('back');
                }

            ),
            Button(
                Icon(Icons.arrow_forward),
                    (){
                  print('forward');
                }

            ),
            Button(
                Icon(Icons.help),
                    (){
                  print('help');
                }

            )

          ],
        ),
      ),
    );
  }


}



class BottomBar extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(

      color: Colors.green,

      child: Row(

        children: <Widget>[

          Button(
              Icon(Icons.arrow_back),
                  (){
                print('back');
              }

          ),
          Button(
              Icon(Icons.arrow_forward),
                  (){
                print('forward');
              }

          ),
          Button(
              Icon(Icons.help),
              (){
                print('help');
              }

          )

        ],
      ),
    );
  }


}


class Button extends StatelessWidget{

  final Icon icon;
  final Function onPressed;

  Button(this.icon, this.onPressed);
  
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return  Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: RaisedButton(
          color: Colors.greenAccent,
          onPressed: onPressed,
          child: icon,
        ),
      ),
    );
  }


}