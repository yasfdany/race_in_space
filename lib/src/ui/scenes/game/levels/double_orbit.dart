import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/geometry.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../entities/level/level.dart';
import '../../../../entities/planet/planet.dart';
import '../../../../entities/ship/ship.dart';
import '../../../../entities/solar/solar.dart';

class DoubleOrbit extends Level {
  DoubleOrbit()
      : super(
          name: 'Double Orbit',
          level: 4,
          zoom: 1,
          canZoom: false,
          solar: 6,
          world: World(),
          startingPos: Vector2(0, (1.sh / 3)),
          spaceColor: Color(0xFF7C4DFF),
        );

  Planet get _planet1 {
    return Planet(
      radius: 40,
      gravityArea: 3,
      type: PlanetType.gas,
      position: Vector2(0, 40),
      color: Colors.blue,
    );
  }

  Planet get _planet2 {
    return Planet(
      radius: 30,
      gravityArea: 3,
      type: PlanetType.dry,
      position: Vector2(74, -264),
      color: Colors.deepOrange,
    );
  }

  @override
  World get world {
    return World(children: [
      _planet1,
      _planet2,
      ..._generatePlanetSolar1(),
      ..._generatePlanetSolar2(),
      Ship(position: startingPos),
    ]);
  }

  List<Component> _generatePlanetSolar1() {
    return List.generate(solar - 3, (i) {
      final radius = 80;
      final angle = (i * tau / 12) - (tau / 1.7);

      double satelliteX = radius * cos(angle);
      double satelliteY = radius * sin(angle);

      return Solar(
        angle: angle,
        position: _planet1.position + Vector2(satelliteX, satelliteY),
      );
    });
  }

  List<Component> _generatePlanetSolar2() {
    return List.generate(solar - 3, (i) {
      final radius = 60;
      final angle = (i * tau / 12);

      double satelliteX = radius * cos(angle);
      double satelliteY = radius * sin(angle);

      return Solar(
        angle: angle,
        position: _planet2.position + Vector2(satelliteX, satelliteY),
      );
    });
  }
}
