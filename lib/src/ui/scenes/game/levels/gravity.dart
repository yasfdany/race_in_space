import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/geometry.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../entities/finish_line/finish_line.dart';
import '../../../../entities/level/level.dart';
import '../../../../entities/planet/planet.dart';
import '../../../../entities/ship/ship.dart';
import '../../../../entities/solar/behaviors/satellite_behavior.dart';
import '../../../../entities/solar/solar.dart';

class Gravity extends Level {
  Gravity()
      : super(
          name: 'Gravity',
          level: 2,
          zoom: 1,
          canZoom: false,
          entities: [],
        );

  @override
  @override
  List<Component> get entities {
    return [
      FinishLine(position: Vector2(0, (-1.sh / 2) + 20)),
      Planet(
        radius: 40,
        gravityArea: 3,
        position: Vector2.zero(),
      ),
      ..._generateSolarSatellite(),
      Ship(),
    ];
  }

  List<Component> _generateSolarSatellite() {
    return List.generate(
      5,
      (i) {
        final radius = 90;
        final angle = i * tau / 12;

        double satelliteX = radius * cos(angle);
        double satelliteY = radius * sin(angle);

        return Solar(
          angle: angle,
          position: Vector2(satelliteX, satelliteY),
        )..add(SatelliteBehavior(center: Vector2.zero(), radius: 90));
      },
    );
  }
}
