import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../entities/level/level.dart';
import '../../../../entities/ship/ship.dart';
import '../../../../entities/solar/solar.dart';

class SolarEnergy extends Level {
  SolarEnergy()
      : super(
          name: 'Solar Energy',
          level: 1,
          zoom: 1,
          canZoom: false,
          world: World(),
          startingPos: Vector2(0, (1.sh / 3)),
          spaceColor: Colors.indigo,
        );

  @override
  World get world {
    return World(children: [
      ...List.generate(
        solar,
        (i) => Solar(position: Vector2(0, (i * 50) - 100)),
      ),
      Ship(position: startingPos),
    ]);
  }
}
