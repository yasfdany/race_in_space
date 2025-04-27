import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import '../nebulae_gas/nebulae_gas_background.dart';
import '../trail/trail.dart';

class Level {
  String name;
  int level;
  World world;
  int solar;
  int attempts;
  int star;
  double zoom;
  bool canZoom;
  Vector2 startingPos;
  Color spaceColor;

  Level({
    required this.name,
    required this.level,
    required this.world,
    required this.startingPos,
    this.spaceColor = Colors.green,
    this.solar = 6,
    this.attempts = 3,
    this.star = 0,
    this.zoom = 1,
    this.canZoom = true,
  });

  NebulaeGasBackground get background => NebulaeGasBackground(
        color: spaceColor,
      );

  List<Trail> get trails => [
        for (int i = 0; i < 20; i++) Trail(index: 0),
      ];
}
