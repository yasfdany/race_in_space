import 'package:flame/components.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../entities/finish_line/finish_line.dart';
import '../../../../entities/level/level.dart';
import '../../../../entities/planet/planet.dart';
import '../../../../entities/ship/ship.dart';
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
      Solar(position: Vector2(-60, -80)),
      Solar(position: Vector2(-80, 0)),
      Solar(position: Vector2(-60, 80)),
      Solar(position: Vector2(60, -80)),
      Solar(position: Vector2(80, 0)),
      Solar(position: Vector2(60, 80)),
      Ship(),
    ];
  }
}
