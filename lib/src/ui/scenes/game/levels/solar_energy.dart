import 'package:flame/components.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../entities/finish_line/finish_line.dart';
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
          entities: [],
        );

  @override
  List<Component> get entities {
    return [
      FinishLine(position: Vector2(0, (-1.sh / 2) + 20)),
      ...List.generate(5, (i) => Solar(position: Vector2(0, (i * 40) - 100))),
      Ship(),
    ];
  }
}
