import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flutter/material.dart';

import '../../../main.dart';
import '../../config/di/get_it_ext.dart';
import '../../utils/helpers/random_helper.dart';

class BigStar extends SpriteComponent with HasGameReference {
  BigStar({
    required super.position,
  });
  final assetsController = locator.assetsController;

  @override
  void onLoad() {
    anchor = Anchor.center;
    final variation = RandomHelper.randomRangeInt(
      min: 0,
      max: 24,
    );
    size = Vector2.all(25);
    scale = Vector2.all(RandomHelper.randomRangeDouble(
      min: 1,
      max: 2,
    ));
    sprite = Sprite(
      assetsController.bigStars,
      srcPosition: Vector2(25.0 * variation, 0),
      srcSize: Vector2.all(25.0),
    );

    add(ScaleEffect.by(
      Vector2.all(0.5),
      EffectController(
        duration: 1,
        curve: Curves.easeInOut,
        reverseDuration: 1,
        infinite: true,
      ),
    ));
  }

  @override
  void update(double dt) {
    super.update(dt);
    position.y += 5 * dt;
    if (position.y > game.size.y) {
      position = randomPosition();
    }
  }

  Vector2 randomPosition() {
    return Vector2(
      RandomHelper.randomRangeDouble(
        min: 0,
        max: game.size.x,
      ),
      RandomHelper.randomRangeDouble(
        min: -game.size.y,
        max: 0,
      ),
    );
  }
}
