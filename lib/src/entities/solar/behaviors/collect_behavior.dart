import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flame/effects.dart';
import 'package:flame/game.dart';
import 'package:flame_behaviors/flame_behaviors.dart';
import 'package:flutter/material.dart';

import '../../../../main.dart';
import '../../../config/di/get_it_ext.dart';
import '../../../ui/scenes/game/controllers/game_controller.dart';
import '../../../ui/scenes/game/ui/win_dialog.dart';
import '../../ship/ship_sprite.dart';
import '../solar.dart';

class CollectBehavior extends CollisionBehavior<ShipSprite, Solar> {
  late final gameController = locator.get<GameController>();
  late final state = gameController.state;

  final audioController = locator.audioController;

  @override
  void onCollisionStart(
    Set<Vector2> intersectionPoints,
    ShipSprite other,
  ) async {
    if (parent.collected) return;
    audioController.playCollect(
      parent.position,
      1 + (state.solarCollected / 10),
    );
    parent.collected = true;

    super.onCollisionStart(intersectionPoints, other);
    animateCollected();

    state.solarCollected++;

    if (state.solarCollected == state.level.solar) {
      await 1.delay();
      gameController.game.overlays.add(WinDialog.overlayName);
    }
  }

  void animateCollected() {
    final controller = EffectController(
      duration: 0.1,
      curve: Curves.fastOutSlowIn,
    );
    parent.add(SequenceEffect(
      [
        ScaleEffect.to(
          Vector2.all(1.2),
          controller,
        ),
        ScaleEffect.to(
          Vector2.all(0),
          controller,
        ),
      ],
      onComplete: parent.removeFromParent,
    ));
  }
}
