

import 'package:flutter/services.dart';
import 'package:swurdlelogic/swurdlelogic.dart';


AssetBundle _initBundle() {
  if (rootBundle != null)
    return rootBundle;
  return new NetworkAssetBundle(new Uri.directory(Uri.base.origin));
}

final AssetBundle _bundle = _initBundle();

class FlutterInterface extends Interface{

  double horizontalSize = 600;
  double verticalSize = 800;

  FlutterInterface();

  @override
  loadGraphics() {
    // TODO: implement loadGraphics
    return null;
  }

  Future<String> loadString(String fileName) async{
    return await _bundle.loadString('packages/swurdlelogic/assets/' + fileName);
  }

  @override
  redraw() {
    // TODO: implement redraw
    return null;
  }










}