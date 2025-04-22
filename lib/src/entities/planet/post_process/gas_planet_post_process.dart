import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/post_process.dart';
import 'package:flutter_shaders/flutter_shaders.dart';

import '../../../utils/helpers/color_helper.dart';

class GasPlanetPostProcess extends PostProcess {
  GasPlanetPostProcess({
    required this.baseColor,
  });
  late World world;
  late final FragmentProgram fragmentProgram;
  late final FragmentShader shader;

  final Color baseColor;
  late final colors = ColorHelper.generatePaletteColors(
    baseColor,
    count: 4,
  );

  double time = 0;

  @override
  void update(double dt) {
    super.update(dt);
    time += dt;
  }

  @override
  void onLoad() async {
    fragmentProgram = await FragmentProgram.fromAsset(
      'assets/shaders/gas_planet.frag',
    );
    shader = fragmentProgram.fragmentShader();
  }

  @override
  void postProcess(Vector2 size, Canvas canvas) {
    shader.setFloatUniforms((value) {
      value
        ..setVector(size) // iResolution
        ..setFloat(time * 2) // iTime
        ..setFloat(1.0) // seed
        ..setFloat(30.0) // size
        ..setFloat(80);

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
