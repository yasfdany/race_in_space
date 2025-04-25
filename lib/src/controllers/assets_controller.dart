import 'dart:ui' show Image;

import 'package:flame/flame.dart';

import '../../r.dart' show AssetImages;
import '../utils/extensions/assets_ext.dart';

class AssetsController {
  late Image rocket;
  late Image finish;
  late Image asteroids;
  late Image stars;
  late Image bigStars;
  late Image exhaust;
  late Image explosion;

  Future<void> init() async {
    rocket = await Flame.images.load(
      AssetImages.rocket.fileName,
    );
    finish = await Flame.images.load(
      AssetImages.finish.fileName,
    );
    asteroids = await Flame.images.load(
      AssetImages.asteroids.fileName,
    );
    stars = await Flame.images.load(
      AssetImages.stars.fileName,
    );
    bigStars = await Flame.images.load(
      AssetImages.bigStars.fileName,
    );
    exhaust = await Flame.images.load(
      AssetImages.exhaust.fileName,
    );
    explosion = await Flame.images.load(
      AssetImages.explosion.fileName,
    );
  }
}
