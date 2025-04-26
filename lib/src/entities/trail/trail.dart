import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class Trail extends CircleComponent {
  Trail({
    super.position,
    super.anchor = Anchor.center,
    super.radius = 2.5,
    this.index = 0,
  });

  int index;

  @override
  Future<void> onLoad() {
    paint = Paint()..color = Colors.yellow;
    return super.onLoad();
  }

  void updateOpacity() {
    opacity = 0.8 - (index / 40);

    scale.x = 1.5 - (index / 20);
    scale.y = 1.5 - (index / 20);
  }
}
