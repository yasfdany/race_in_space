import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/geometry.dart';
import 'package:flutter/material.dart';

import '../../../../entities/asteroid/asteroid.dart';
import '../../../../entities/level/level.dart';
import '../../../../entities/planet/planet.dart';
import '../../../../entities/ship/ship.dart';
import '../../../../entities/solar/solar.dart';
import '../../../../entities/star/star_background.dart';

class Asteroids extends Level {
  Asteroids()
      : super(
          name: 'Asteroids',
          level: 3,
          zoom: 1,
          canZoom: false,
          solar: 5,
          world: World(),
          startingPos: Vector2(-80, 280),
          spaceColor: Color.fromARGB(255, 22, 139, 112),
        );

  Planet get _planet {
    return Planet(
      radius: 40,
      gravityArea: 3,
      position: Vector2(42, -164),
      color: Color(0xff4FD1B3),
    );
  }

  @override
  World get world {
    return World(children: [
      background,
      StarBackground(),
      _planet,
      ..._generateSolarEnergy(),
      Ship(position: startingPos),
      ..._generateAsteroid(),
    ]);
  }

  List<Component> _generateAsteroid() {
    return [
      Asteroid(position: Vector2(-130, -16)),
      Asteroid(position: Vector2(-94, -34)),
      Asteroid(position: Vector2(-106, 24)),
      Asteroid(position: Vector2(-68, 0)),
      Asteroid(position: Vector2(-50, -34)),
      Asteroid(position: Vector2(-12, 0)),
      Asteroid(position: Vector2(-38, 30)),
      Asteroid(position: Vector2(126, -10)),
      Asteroid(position: Vector2(156, -42)),
      Asteroid(position: Vector2(178, -4)),
    ];
  }

  List<Component> _generateSolarEnergy() {
    return List.generate(solar, (i) {
      final radius = 100.0;
      final angle = (i * tau / 12) - (tau / 6);

      double satelliteX = radius * cos(angle);
      double satelliteY = radius * sin(angle);

      return Solar(
        index: i,
        angle: angle,
        position: _planet.position + Vector2(satelliteX, satelliteY),
      );
    });
  }
}
