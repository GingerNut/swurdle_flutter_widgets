

import 'package:flutter/widgets.dart';
import 'package:swurdle_flutter_widgets/flutter_interface.dart';


class UI extends InheritedWidget{

  final FlutterInterface ui;

  UI({this.ui, Widget child}) : super(child: child);

  bool updateShouldNotify(InheritedWidget oldWidget) {

    return true;
  }


  static UI of(BuildContext context) {
    return context.inheritFromWidgetOfExactType(UI) as UI;
  }


}

