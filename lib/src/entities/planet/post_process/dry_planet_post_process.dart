import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/post_process.dart';
import 'package:flutter_shaders/flutter_shaders.dart';

import '../../../utils/helpers/color_helper.dart';

class DryPlanetPostProcess extends PostProcess {
  DryPlanetPostProcess({
    required this.baseColor,
  });
  late World world;
  late final FragmentProgram fragmentProgram;
  late final FragmentShader shader;

  final Color baseColor;
  late final colors = ColorHelper.generatePaletteColors(baseColor);

  double time = 0;

  @override
  void update(double dt) {
    super.update(dt);
    time += dt;
  }

  @override
  void onLoad() async {
    fragmentProgram = await FragmentProgram.fromAsset(
      'assets/shaders/dry_planet.frag',
    );
    shader = fragmentProgram.fragmentShader();
  }

  @override
  void postProcess(Vector2 size, Canvas canvas) {
    shader.setFloatUniforms((value) {
      value
        ..setVector(size) // iResolution
        ..setFloat(time * 10) // iTime
        ..setFloat(10.0) // seed
        ..setFloat(10.0) // size
        ..setFloat(80); // pixels

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
