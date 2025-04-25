import 'package:flame/game.dart';
import 'package:flame_behaviors/flame_behaviors.dart';

import '../../../../main.dart';
import '../../../config/di/get_it_ext.dart';
import '../../../ui/scenes/game/controllers/game_controller.dart';
import '../../../utils/extensions/camera_ext.dart';
import '../../ship/explosion.dart';
import '../../ship/ship_sprite.dart';
import '../asteroid.dart';

class CollideBehavior extends CollisionBehavior<ShipSprite, Asteroid> {
  late final gameController = locator.get<GameController>();
  final audioController = locator.audioController;

  @override
  void onCollision(Set<Vector2> intersectionPoints, ShipSprite other) async {
    super.onCollision(intersectionPoints, other);
    audioController.stopCombust();
    audioController.playExplode(parent.position);

    gameController.game.camera.shakeCamera();
    gameController.game.world.add(Explosion(
      position: other.ship.position,
    ));
    other.ship.reset();
  }
}
