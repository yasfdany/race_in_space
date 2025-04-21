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
  late Image asteroid;
  late Image stars;
  late Image bigStars;

  void init() async {
    rocket = await Flame.images.load(
      AssetImages.rocket.fileName,
    );
    finish = await Flame.images.load(
      AssetImages.finish.fileName,
    );
    asteroid = await Flame.images.load(
      AssetImages.asteroid.fileName,
    );
    stars = await Flame.images.load(
      AssetImages.stars.fileName,
    );
    bigStars = await Flame.images.load(
      AssetImages.bigStars.fileName,
    );
  }
}
