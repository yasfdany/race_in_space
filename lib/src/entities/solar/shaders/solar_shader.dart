import 'package:flame/components.dart';
import 'package:flame/post_process.dart';

import '../../../ui/scenes/game/game_scene.dart';
import '../post_process/solar_post_process.dart';

class SolarShader extends PostProcessComponent<SolarPostProcess>
    with HasGameReference<GameScene> {
  SolarShader({
    required super.size,
  }) : super(postProcess: SolarPostProcess());

  @override
  Future<void> onLoad() async {
    postProcess.world = game.world;
    await super.onLoad();
  }
}
