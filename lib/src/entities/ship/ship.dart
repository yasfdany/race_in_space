import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/geometry.dart';
import 'package:flame_behaviors/flame_behaviors.dart';
import 'package:flutter/material.dart';

import '../../../main.dart';
import '../../config/di/get_it_ext.dart';
import '../../ui/scenes/game/controllers/game_controller.dart';
import '../../ui/scenes/game/game_scene.dart';
import '../solar/solar.dart';
import '../trajectory/trajectory.dart';
import 'behaviors/pull_behavior.dart';
import 'behaviors/velocity_behavior.dart';
import 'ship_sprite.dart';

enum ShipState {
  idle,
  moving,
}

class Ship extends PositionedEntity with HasGameReference<GameScene> {
  Ship({
    super.position,
  }) : super(behaviors: _buildBehaviors);

  static List<Behavior<EntityMixin>> get _buildBehaviors {
    return [
      VelocityBehavior(),
      PullBehavior(),
    ];
  }

  late final gameController = locator.get<GameController>();
  final audioController = locator.audioController;

  late ShipSprite shipSprite;

  Vector2 velocity = Vector2(0, 0);
  ShipState state = ShipState.idle;

  late final trajectories = [
    for (var i = 0; i < 10; i++)
      Trajectory(
        index: i,
        position: Vector2.zero(),
      )
  ];

  late final startPosition = position.clone();

  @override
  void onLoad() {
    position.y = (game.size.y / 2) + 100;
    size = Vector2(56, 56);
    anchor = Anchor.center;
    shipSprite = ShipSprite(
      position: size / 2,
    );

    addAll(trajectories);
    add(shipSprite);
    animateShipAppear();
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (velocity.length > 0) {
      shipSprite.angle = atan2(velocity.y, velocity.x) + tau / 4;
      state = ShipState.moving;
    }
    final viewportSize = (game.size / 2) / game.camera.viewfinder.zoom;
    if ((position.x > viewportSize.x ||
            position.x < -viewportSize.x ||
            position.y > viewportSize.y ||
            position.y < -viewportSize.y) &&
        state == ShipState.moving) {
      reset();
    }
  }

  void reset() {
    audioController.stopCombust();
    gameController.state.aimVelocity = Vector2.zero();

    position = gameController.state.level.startingPos;
    position.y = (game.size.y / 2) + 100;

    animateShipAppear(delay: false, initial: false);

    shipSprite.angle = 0;
    velocity = Vector2(0, 0);
    state = ShipState.idle;
  }

  void animateShipAppear({
    bool delay = true,
    bool initial = true,
  }) {
    final isWin = game.world.children.whereType<Solar>().isEmpty;
    if (isWin && !initial) return;

    add(MoveEffect.to(
      gameController.state.level.startingPos,
      EffectController(
        startDelay: delay ? gameController.state.level.solar * 0.1 : 0,
        duration: 1,
        curve: Curves.fastOutSlowIn,
      ),
    ));
  }
}
