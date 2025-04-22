import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/post_process.dart';
import 'package:flutter_shaders/flutter_shaders.dart';

import '../../../utils/helpers/color_helper.dart';

class BubblePostProcess extends PostProcess {
  BubblePostProcess({
    required this.color,
  });
  late World world;
  late final FragmentProgram fragmentProgram;
  late final FragmentShader shader;

  double time = 0;

  final Color color;
  late final colors = ColorHelper.generatePaletteColors(color, count: 3);

  @override
  void update(double dt) {
    super.update(dt);
    time += dt;
  }

  @override
  void onLoad() async {
    fragmentProgram = await FragmentProgram.fromAsset(
      'assets/shaders/gravity_bubble.frag',
    );
    shader = fragmentProgram.fragmentShader();
  }

  @override
  void postProcess(Vector2 size, Canvas canvas) {
    shader.setFloatUniforms((value) {
      value
        ..setVector(size) // iResolution
        ..setFloat(time); // iTime

      for (final color in colors) {
        value.setColor(color);
      }
    });

    canvas
      ..save()
      ..drawRect(Offset.zero & size.toSize(), Paint()..shader = shader)
      ..restore();
  }
}
