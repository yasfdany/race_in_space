import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/post_process.dart';
import 'package:flutter_shaders/flutter_shaders.dart';

class GasPlanetPostProcess extends PostProcess {
  late World world;
  late final FragmentProgram fragmentProgram;
  late final FragmentShader shader;

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
        ..setFloat(time) // iTime
        ..setFloat(1.0) // seed
        ..setFloat(20.0) // size
        ..setFloat(76); // pixels
    });

    canvas
      ..save()
      ..drawRect(Offset.zero & size.toSize(), Paint()..shader = shader)
      ..restore();
  }
}
