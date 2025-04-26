import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import '../../../../entities/level/level.dart';
import '../../../../entities/ship/ship.dart';
import '../../../../entities/solar/solar.dart';
import '../../../../entities/star/star_background.dart';

class SolarEnergy extends Level {
  SolarEnergy()
      : super(
          name: 'Solar Energy',
          level: 1,
          zoom: 1,
          canZoom: false,
          world: World(),
          startingPos: Vector2(0, 280),
          spaceColor: Colors.indigo,
        );

  @override
  World get world {
    return World(children: [
      background,
      StarBackground(),
      ...List.generate(
        solar,
        (i) => Solar(
          index: solar - i,
          position: Vector2(0, (i * 50) - 100),
        ),
      ),
      ...trails,
      Ship(position: startingPos),
    ]);
  }
}
