import 'package:flame/game.dart';
import 'package:flame_behaviors/flame_behaviors.dart';

import '../../../../main.dart';
import '../../../ui/scenes/game/controllers/game_controller.dart';
import '../../ship/ship_sprite.dart';
import '../asteroid.dart';

class CollideBehavior extends CollisionBehavior<ShipSprite, Asteroid> {
  late final _gameController = locator.get<GameController>();

  @override
  void onCollision(Set<Vector2> intersectionPoints, ShipSprite other) async {
    super.onCollision(intersectionPoints, other);
    other.ship.reset();
  }
}
