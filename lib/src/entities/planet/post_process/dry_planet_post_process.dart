import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/post_process.dart';
import 'package:flutter_shaders/flutter_shaders.dart';

import '../../../../main.dart';
import '../../../config/di/get_it_ext.dart';
import '../../../utils/helpers/color_helper.dart';

class DryPlanetPostProcess extends PostProcess {
  DryPlanetPostProcess({
    required this.baseColor,
  });
  late World world;
  late final shader = shaderController.dryPlanetShader;
  late final colors = ColorHelper.generatePaletteColors(baseColor);

  final Color baseColor;
  final shaderController = locator.shaderController;

  double time = 0;

  @override
  void update(double dt) {
    super.update(dt);
    time += dt;
  }

  @override
  void postProcess(Vector2 size, Canvas canvas) {
    shader.setFloatUniforms((value) {
      value
        ..setVector(size) // iResolution
        ..setFloat(time * 10) // iTime
        ..setFloat(10.0) // seed
        ..setFloat(10.0) // size
        ..setFloat(80) // pixels
        ..setColors(colors); // colors
    });

    canvas
      ..save()
      ..drawRect(Offset.zero & size.toSize(), Paint()..shader = shader)
      ..restore();
  }
}
