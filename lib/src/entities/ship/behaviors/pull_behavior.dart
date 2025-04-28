import 'dart:math';

import 'package:flame/effects.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame/geometry.dart';
import 'package:flame_behaviors/flame_behaviors.dart';
import 'package:flutter/widgets.dart';

import '../../../../main.dart';
import '../../../config/di/get_it_ext.dart';
import '../../../ui/scenes/game/controllers/game_state.dart';
import '../../../ui/scenes/game/ui/tutorial_overlay.dart';
import '../../trail/trail.dart';
import '../ship.dart';

class PullBehavior extends DraggableBehavior<Ship> {
  final gameState = locator.get<GameState>();
  final audioController = locator.audioController;
  final prefHelper = locator.prefHelper;
  late final tutorialShown = prefHelper.tutorialShown;

  @override
  void onDragUpdate(DragUpdateEvent event) {
    if (parent.state == ShipState.moving) return;

    final potentialNewPos = parent.position + event.localDelta;
    final newDistance = (potentialNewPos - gameState.level.startingPos).length;

    if (newDistance <= 100) {
      parent.position += event.localDelta;
    } else {
      final direction =
          (potentialNewPos - gameState.level.startingPos).normalized();
      parent.position = gameState.level.startingPos + direction * 100;
    }

    final direction = parent.position - parent.startPosition;
    if (direction.length > 0) {
      parent.shipSprite.angle = atan2(-direction.y, -direction.x) + tau / 4;
    }

    final distance =
        parent.startPosition.distanceTo(parent.position).clamp(0.0, 100.0);
    gameState.aimVelocity =
        -(parent.position - parent.startPosition).normalized() * distance * 5;

    if (!tutorialShown &&
        parent.game.overlays.isActive(TutorialOverlay.overlayName)) {
      if (distance > 30) {
        parent.game.overlays.remove(TutorialOverlay.overlayName);
        prefHelper.tutorialShown = true;
      }
    }

    super.onDragUpdate(event);
  }

  @override
  void onDragEnd(DragEndEvent event) async {
    if (parent.state == ShipState.moving) return;
    final distance =
        parent.startPosition.distanceTo(parent.position).clamp(0.0, 100.0);
    final velocity =
        -(parent.position - parent.startPosition).normalized() * distance * 5;

    if (velocity.length < 200) {
      gameState.aimVelocity = Vector2.zero();
      parent.add(
        MoveEffect.to(
          gameState.level.startingPos,
          EffectController(
            duration: 0.1,
            curve: Curves.fastOutSlowIn,
          ),
        ),
      );
      return;
    }

    audioController.playRocketLaunch();
    audioController.playCombust();

    parent.state = ShipState.moving;
    parent.velocity = velocity;

    gameState.aimVelocity = Vector2.zero();
    parent.shipSprite.exhaust.playing = true;
    parent.shipSprite.exhaust.scale = Vector2.all(
      (parent.velocity.y / 200).abs().clamp(0, 1.2),
    );

    _hideTrails();

    super.onDragEnd(event);
  }

  void _hideTrails() {
    final trails = parent.game.world.children.whereType<Trail>().toList();
    for (final trail in trails) {
      trail.add(OpacityEffect.fadeOut(EffectController(
        duration: 0.5,
        curve: Curves.fastOutSlowIn,
      )));
    }
  }
}
