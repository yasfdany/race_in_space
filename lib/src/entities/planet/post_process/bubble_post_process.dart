import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/post_process.dart';
import 'package:flutter_shaders/flutter_shaders.dart';

import '../../../../main.dart';
import '../../../config/di/get_it_ext.dart';
import '../../../utils/helpers/color_helper.dart';

class BubblePostProcess extends PostProcess {
  BubblePostProcess({
    required this.color,
  });
  late World world;
  late final shader = shaderController.gravityBubbleShader;
  late final colors = ColorHelper.generatePaletteColors(color, count: 3);

  final Color color;
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
        ..setFloat(time) // iTime
        ..setColors(colors); // colors
    });

    canvas
      ..save()
      ..drawRect(Offset.zero & size.toSize(), Paint()..shader = shader)
      ..restore();
  }
}
