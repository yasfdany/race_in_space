import 'package:flame/components.dart';
import 'package:flame/post_process.dart';
import 'package:flutter/material.dart';

import 'post_process/nebulae_gas_process.dart';

class NebulaeGasBackground extends PostProcessComponent<NebulaeGasPostProcess>
    with HasGameReference {
  NebulaeGasBackground({
    required this.color,
  }) : super(postProcess: _buildPostProcess(color));

  static NebulaeGasPostProcess _buildPostProcess(Color color) {
    return NebulaeGasPostProcess(color: color);
  }

  final Color color;

  @override
  Future<void> onLoad() async {
    size = game.size;
    position = -size / 2;
    postProcess.world = game.world;
    await super.onLoad();
  }
}
