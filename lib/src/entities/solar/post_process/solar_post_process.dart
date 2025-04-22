import 'package:flame/components.dart';
import 'package:flame/post_process.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shaders/flutter_shaders.dart';

import '../../../../main.dart';
import '../../../config/di/get_it_ext.dart';
import '../../../utils/helpers/color_helper.dart';

class SolarPostProcess extends PostProcess {
  late World world;
  late final shader = shaderController.solarShader;
  late final colors = ColorHelper.generatePaletteColors(
    Colors.orange,
    count: 4,
  );

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
        ..setFloat(time * 2) // iTime
        ..setFloat(30) // pixels
        ..setColors([
          Color(0xFF662100), // darkColor - Deep reddish-brown
          Color(0xFFE6400D), // midColor - Fiery orange
          Color(0xFFFF8C1A), // lightColor - Bright orange
          Color(0xFFFFC966), // lightestColor - Soft golden glow
        ]); // colors
    });

    canvas
      ..save()
      ..drawRect(Offset.zero & size.toSize(), Paint()..shader = shader)
      ..restore();
  }
}
