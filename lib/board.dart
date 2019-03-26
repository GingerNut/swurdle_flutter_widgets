

import 'package:flutter/material.dart';

class FlutterBoard extends StatelessWidget{

  final double height;
  final double width;

  FlutterBoard(this.height, this.width);

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