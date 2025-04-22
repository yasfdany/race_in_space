import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/post_process.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shaders/flutter_shaders.dart';

class NebulaeGasPostProcess extends PostProcess {
  NebulaeGasPostProcess({
    required this.color,
  });
  late World world;
  late final FragmentProgram fragmentProgram;
  late final FragmentShader shader;
  late final seed = DateTime.now().millisecondsSinceEpoch % 1000.0;

  final Color color;

  double time = 0;

  @override
  void update(double dt) {
    super.update(dt);
    time += dt;
  }

  @override
  void onLoad() async {
    fragmentProgram = await FragmentProgram.fromAsset(
      'assets/shaders/nebulae_gas.frag',
    );
    shader = fragmentProgram.fragmentShader();
  }

  @override
  void postProcess(Vector2 size, Canvas canvas) {
    shader.setFloatUniforms((value) {
      value
        ..setVector(size) // iResolution
        ..setFloat(time) // iTime
        ..setFloat(seed) // seed
        ..setFloat(20.0) // size
        ..setFloat(400) // pixels
        ..setColor(Colors.black) // dark color
        ..setColor(color); // light color
    });

    canvas
      ..save()
      ..drawRect(Offset.zero & size.toSize(), Paint()..shader = shader)
      ..restore();
  }
}
