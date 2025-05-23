import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/geometry.dart';
import 'package:flutter/material.dart';

import '../../../../entities/level/level.dart';
import '../../../../entities/planet/planet.dart';
import '../../../../entities/ship/ship.dart';
import '../../../../entities/solar/behaviors/satellite_behavior.dart';
import '../../../../entities/solar/solar.dart';
import '../../../../entities/star/star_background.dart';

class Gravity extends Level {
  Gravity()
      : super(
          name: 'Gravity',
          level: 2,
          zoom: 1,
          canZoom: false,
          world: World(),
          startingPos: Vector2(0, 280),
          spaceColor: Color(0xFF2E3A87),
        );

  @override
  World get world {
    return World(children: [
      background,
      StarBackground(),
      Planet(
        radius: 40,
        gravityArea: 3,
        position: Vector2.zero(),
        color: Color(0xffFF7043),
      ),
      ..._generateSolarSatellite(),
      ...trails,
      Ship(position: startingPos),
    ]);
  }

  List<Component> _generateSolarSatellite() {
    return List.generate(solar, (i) {
      final radius = 90;
      final angle = (tau / 2) + (i * tau / 12);

      double satelliteX = radius * cos(angle);
      double satelliteY = radius * sin(angle);

      return Solar(
        index: i,
        angle: angle,
        position: Vector2(satelliteX, satelliteY),
      )..add(SatelliteBehavior(center: Vector2.zero(), radius: 90));
    });
  }
}
