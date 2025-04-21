import 'package:flame/components.dart';
import 'package:flame_behaviors/flame_behaviors.dart';

import '../../../../main.dart';
import '../../../ui/scenes/game/controllers/game_state.dart';
import '../trajectory.dart';

class AimBehavior extends Behavior<Trajectory> {
  final _gameState = locator.get<GameState>();

  @override
  void update(double dt) {
    super.update(dt);

    final steps = parent.index + 1;
    final timeStep = 0.1;

    Vector2 pos = parent.ship.shipSprite.position.clone();
    Vector2 vel = _gameState.aimVelocity.clone();

    for (int i = 0; i < steps; i++) {
      pos += vel * timeStep;
    }

    parent.position = pos;
  }
}
