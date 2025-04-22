import 'package:flame/components.dart';
import 'package:flame/post_process.dart';
import 'package:flutter/material.dart';

import '../../../ui/scenes/game/game_scene.dart';
import '../post_process/dry_planet_post_process.dart';

class DryPlanetShader extends PostProcessComponent<DryPlanetPostProcess>
    with HasGameReference<GameScene> {
  DryPlanetShader({
    required super.size,
    required this.color,
  }) : super(postProcess: _buildPostProcess(color));

  static DryPlanetPostProcess _buildPostProcess(Color color) {
    return DryPlanetPostProcess(baseColor: color);
  }

  final Color color;

  @override
  Future<void> onLoad() async {
    postProcess.world = game.world;
    await super.onLoad();
  }
}
