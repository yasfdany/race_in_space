import 'package:flutter/material.dart';

class ColorHelper {
  static List<Color> generatePaletteColors(Color baseColor, {int count = 5}) {
    final baseHSL = HSLColor.fromColor(baseColor);

    final lightnessSteps = List.generate(
      count,
      (i) => (baseHSL.lightness - i * 0.1).clamp(0.1, 0.9),
    );

    return lightnessSteps.map((l) {
      return HSLColor.fromAHSL(
        1.0,
        baseHSL.hue,
        baseHSL.saturation,
        l,
      ).toColor();
    }).toList();
  }
}
