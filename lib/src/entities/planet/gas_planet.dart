import 'package:flame/components.dart';
import 'package:flame/post_process.dart';
import 'package:flutter/material.dart';

import '../../ui/scenes/game/game_scene.dart';
import 'post_process/gas_planet_post_process.dart';

class GasPlanet extends PostProcessComponent<GasPlanetPostProcess>
    with HasGameReference<GameScene> {
  GasPlanet({
    required super.size,
    required this.color,
  }) : super(postProcess: _buildPostProcess(color));

  static GasPlanetPostProcess _buildPostProcess(Color color) {
    return GasPlanetPostProcess(baseColor: color);
  }

  final Color color;

  @override
  Future<void> onLoad() async {
    postProcess.world = game.world;
    await super.onLoad();
  }
}
