import 'package:flame/extensions.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import '../../../entities/nebulae_gas/nebulae_gas_background.dart';
import '../../../entities/star/star_background.dart';
import '../../../utils/helpers/random_helper.dart';

class MainMenuBackground extends FlameGame {
  final colors = [
    Color.fromARGB(255, 22, 139, 112),
    Color(0xFF7C4DFF).darken(0.1),
    Color(0xFF2E3A87),
    Colors.indigo,
  ];
  late final currentColor = RandomHelper.choose(colors);

  @override
  void onLoad() {
    world.addAll([
      StarBackground(),
      NebulaeGasBackground(
        color: currentColor,
      ),
    ]);
  }
}
