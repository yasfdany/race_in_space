import 'dart:math';

import 'package:flame_behaviors/flame_behaviors.dart';

import '../../../utils/helpers/random_helper.dart';
import '../solar.dart';

class FloatyBehavior extends Behavior<Solar> {
  double _time = 0;

  final double amplitudeX = RandomHelper.rangeDouble(
    min: 1,
    max: 4,
  );
  final double amplitudeY = RandomHelper.rangeDouble(
    min: 1,
    max: 4,
  );
  final double speedX = RandomHelper.rangeDouble(
    min: 0.3,
    max: 0.6,
  );
  final double speedY = RandomHelper.rangeDouble(
    min: 0.2,
    max: 0.7,
  );
  final double rotationAmplitude = RandomHelper.rangeDouble(
    min: 0.02,
    max: 0.05,
  );
  final double rotationSpeed = RandomHelper.rangeDouble(
    min: 0.5,
    max: 1.0,
  );

  late final double baseX;
  late final double baseY;

  @override
  void onMount() {
    super.onMount();
    baseX = parent.x;
    baseY = parent.y;
  }

  @override
  void update(double dt) {
    super.update(dt);
    _time += dt;

    parent.x = baseX + amplitudeX * sin(_time * speedX);
    parent.y = baseY + amplitudeY * cos(_time * speedY);

    parent.angle = rotationAmplitude * sin(_time * rotationSpeed);
  }
}
