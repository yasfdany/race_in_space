import 'dart:ui' show Image;

import 'package:flame/flame.dart';

import '../../r.dart' show AssetImages;
import '../utils/extensions/assets_ext.dart';

class AssetsController {
  AssetsController() {
    init();
  }

  late Image rocket;
  late Image finish;

  void init() async {
    rocket = await Flame.images.load(
      AssetImages.rocket.fileName,
    );
    finish = await Flame.images.load(
      AssetImages.finish.fileName,
    );
  }
}
