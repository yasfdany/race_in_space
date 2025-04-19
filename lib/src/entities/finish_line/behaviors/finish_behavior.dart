import 'package:flame/game.dart';
import 'package:flame_behaviors/flame_behaviors.dart';

import '../../../../main.dart';
import '../../../ui/scenes/game/controllers/game_controller.dart';
import '../../../ui/scenes/game/ui/win_dialog.dart';
import '../../ship/ship.dart';
import '../../solar/solar.dart';
import '../finish_line.dart';

class FinishBehavior extends CollisionBehavior<Ship, FinishLine> {
  final _gameController = locator<GameController>();

  @override
  void onCollision(Set<Vector2> intersectionPoints, Ship other) {
    super.onCollision(intersectionPoints, other);
    final solarLeft =
        _gameController.game.world.children.whereType<Solar>().length;
    if (solarLeft == 0) {
      _gameController.game.overlays.add(WinDialog.overlayName);
    }
  }
}
