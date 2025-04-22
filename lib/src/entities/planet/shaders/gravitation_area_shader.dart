import 'package:flame/components.dart';
import 'package:flame/post_process.dart';
import 'package:flutter/material.dart';

import '../../../ui/scenes/game/game_scene.dart';
import '../post_process/bubble_post_process.dart';

class GravitationAreaShader extends PostProcessComponent<BubblePostProcess>
    with HasGameReference<GameScene> {
  GravitationAreaShader({
    required super.size,
    required this.color,
  }) : super(postProcess: _buildPostProcess(color));

  static BubblePostProcess _buildPostProcess(Color color) {
    return BubblePostProcess(color: color);
  }

  final Color color;

  @override
  Future<void> onLoad() async {
    postProcess.world = game.world;
    await super.onLoad();
  }
}
