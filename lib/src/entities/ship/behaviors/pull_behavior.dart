import 'dart:math';

import 'package:flame/events.dart';
import 'package:flame/geometry.dart';
import 'package:flame_behaviors/flame_behaviors.dart';

import '../ship.dart';

class PullBehavior extends DraggableBehavior<Ship> {
  @override
  void onDragUpdate(DragUpdateEvent event) {
    if (parent.state == ShipState.idle) {
      parent.position.add(event.localDelta);

      final direction = parent.position - parent.startPosition;
      if (direction.length > 0) {
        parent.spriteComponent.angle =
            atan2(-direction.y, -direction.x) + tau / 4;
      }
      super.onDragUpdate(event);
    }
  }

  @override
  void onDragEnd(DragEndEvent event) {
    parent.state = ShipState.moving;
    double distance =
        parent.startPosition.distanceTo(parent.position).clamp(0, 100);
    parent.velocity =
        -(parent.position - parent.startPosition).normalized() * distance * 5;
    super.onDragEnd(event);
  }
}
