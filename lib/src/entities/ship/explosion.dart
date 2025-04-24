import 'package:flame/components.dart';

import '../../../main.dart';
import '../../config/di/get_it_ext.dart';

class Explosion extends SpriteAnimationComponent {
  Explosion({
    required super.position,
    super.anchor = Anchor.center,
  });
  final assetsController = locator.assetsController;

  @override
  bool get removeOnFinish => true;

  @override
  void onLoad() {
    size = Vector2(150, 150);
    animation = SpriteAnimation.fromFrameData(
      assetsController.explosion,
      SpriteAnimationData.sequenced(
        amount: 80,
        stepTime: 0.01,
        textureSize: Vector2(100, 100),
        amountPerRow: 10,
        loop: false,
      ),
    );
  }
}
