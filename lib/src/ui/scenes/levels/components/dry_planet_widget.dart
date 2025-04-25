import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_shaders/flutter_shaders.dart';

import '../../../../../main.dart';
import '../../../../config/di/get_it_ext.dart';
import '../../../../utils/helpers/color_helper.dart';
import '../../../../utils/helpers/random_helper.dart';

class PlanetPainter extends CustomPainter {
  PlanetPainter({
    required this.colors,
    required this.shader,
    required this.seed,
    this.time = 0,
    super.repaint,
  });

  final double time;
  final double seed;
  final FragmentShader shader;
  final List<Color> colors;

  @override
  void paint(Canvas canvas, Size size) {
    shader.setFloatUniforms((value) {
      value
        ..setFloat(size.width)
        ..setFloat(size.height)
        ..setFloat(time * 10)
        ..setFloat(seed)
        ..setFloat(10.0)
        ..setFloat(60)
        ..setColors(colors);
    });

    canvas
      ..save()
      ..drawRect(Offset.zero & size, Paint()..shader = shader)
      ..restore();
  }

  @override
  bool shouldRepaint(covariant PlanetPainter oldDelegate) {
    return oldDelegate.time != time;
  }
}

class PlanetWidget extends StatefulWidget {
  final FragmentShader shader;
  final Color baseColor;
  final double width;
  final double height;

  const PlanetWidget({
    super.key,
    required this.baseColor,
    required this.shader,
    this.width = 100,
    this.height = 100,
  });

  @override
  State<PlanetWidget> createState() => _PlanetWidgetState();
}

class _PlanetWidgetState extends State<PlanetWidget> {
  final shaderController = locator.shaderController;

  final ValueNotifier<double> timeNotifier = ValueNotifier(0);
  late final DateTime startTime;

  late final colors = ColorHelper.generatePaletteColors(widget.baseColor);
  final seed = RandomHelper.rangeDouble(min: 1.0, max: 10.0);

  @override
  void initState() {
    super.initState();
    startTime = DateTime.now();

    // Update at 60fps
    Timer.periodic(const Duration(milliseconds: 16), (_) {
      final elapsed = DateTime.now().difference(startTime);
      timeNotifier.value = elapsed.inMilliseconds / 1000.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<double>(
      valueListenable: timeNotifier,
      builder: (context, time, child) {
        return CustomPaint(
          painter: PlanetPainter(
            time: time,
            colors: colors,
            seed: seed,
            shader: widget.shader,
          ),
          size: Size(widget.width, widget.height),
        );
      },
    );
  }
}
