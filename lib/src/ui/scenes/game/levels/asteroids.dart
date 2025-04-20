import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/geometry.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../entities/asteroid/asteroid.dart';
import '../../../../entities/level/level.dart';
import '../../../../entities/planet/planet.dart';
import '../../../../entities/ship/ship.dart';
import '../../../../entities/solar/solar.dart';

class Asteroids extends Level {
  Asteroids()
      : super(
          name: 'Asteroids',
          level: 3,
          zoom: 1,
          canZoom: false,
          solar: 5,
          world: World(),
          startingPos: Vector2(-(1.sw / 4), 1.sh / 3),
        );

  Planet get _planet {
    return Planet(
      radius: 40,
      gravityArea: 3,
      position: Vector2((1.sw / 2) - 160, -160),
    );
  }

  @override
  World get world {
    return World(children: [
      _planet,
      ..._generateSolarEnergy(),
      Ship(position: startingPos),
      ..._generateAsteroid(),
    ]);
  }

  List<Component> _generateAsteroid() {
    return [
      Asteroid(position: Vector2(-130.25894165039062, -16.188201904296875)),
      Asteroid(position: Vector2(-94.87071990966797, -34.25872802734375)),
      Asteroid(position: Vector2(-106.541259765625, 24.84698486328125)),
      Asteroid(position: Vector2(-68.14125061035156, 1.882354736328125)),
      Asteroid(position: Vector2(-50.82359313964844, -35.7647705078125)),
      Asteroid(position: Vector2(-13.176498413085938, 0.0)),
      Asteroid(position: Vector2(-39.90580749511719, 31.62347412109375)),
      Asteroid(position: Vector2(127.24703979492188, -9.78826904296875)),
      Asteroid(position: Vector2(157.36480712890625, -41.411773681640625)),
      Asteroid(position: Vector2(179.5764617919922, -3.388214111328125)),
    ];
  }

  List<Component> _generateSolarEnergy() {
    return List.generate(solar, (i) {
      final radius = 100.0;
      final angle = (i * tau / 12) - (tau / 6);

      double satelliteX = radius * cos(angle);
      double satelliteY = radius * sin(angle);

      return Solar(
        angle: angle,
        position: _planet.position + Vector2(satelliteX, satelliteY),
      );
    });
  }
}
