import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:swurdlelogic/swurdlelogic.dart';

class GameScreen extends StatelessWidget {


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

        body: Body(),
      ),
    );
  }


}



class Body extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      // This makes each child fill the full width of the screen
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        TopBar(),
        Board(800,600),
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



class Board extends StatelessWidget{

  final double height;
  final double width;

  Board(this.height, this.width);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Expanded(
      child: Container(
        color: Colors.lightGreenAccent,
        child: FittedBox(
          child: SizedBox(
            height: height,
            width: width,

            child: Stack(
              children: <Widget>[

                Positioned(

                  top: 20,
                  left: 50,
                  child: Container(
                    color: Colors.green,
                    child: Text('Hello'),

                  ),



                ),

                Positioned(

                  top: 790,
                  left: 550,
                  child: Container(
                    color: Colors.green,
                    child: Text('Hello'),

                  ),



                )

              ],

            ),
          ),
        ),
      ),
    );;
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