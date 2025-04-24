import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import '../../../main.dart';
import '../../config/di/get_it_ext.dart';

class Exhaust extends SpriteAnimationComponent {
  Exhaust({
    required super.position,
    super.anchor = Anchor.topCenter,
  });
  final assetsController = locator.assetsController;
  final _lightSource = Paint()
    ..color = Colors.red
    ..maskFilter = MaskFilter.blur(
      BlurStyle.normal,
      40,
    );

  @override
  void onLoad() {
    size = Vector2(64, 100);
    scale = Vector2.zero();
    playing = false;
    animation = SpriteAnimation.fromFrameData(
      assetsController.exhaust,
      SpriteAnimationData.sequenced(
        amount: 18,
        stepTime: 0.05,
        textureSize: Vector2(128, 200),
        loop: false,
      ),
    );

    animationTicker?.onComplete = () {
      playing = false;
      animationTicker?.reset();
      scale = Vector2.zero();
    };
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    final elapsed = (animationTicker?.elapsed ?? 0).clamp(0, 1);
    final clampedElapsed =
        elapsed > 0.5 ? 0.5 - (elapsed - 0.5) : elapsed.clamp(0, 0.5);

    canvas.drawRect(
      Rect.fromLTWH(
        0,
        0,
        width * clampedElapsed,
        height * clampedElapsed,
      ),
      _lightSource,
    );
  }
}
