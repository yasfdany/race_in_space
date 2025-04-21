import 'package:flame/components.dart';
import 'package:flame/post_process.dart';

import '../../ui/scenes/game/game_scene.dart';
import 'post_process/nebulae_post_process.dart';

class NebulaeDustBackground extends PostProcessComponent<NebulaePostProcess>
    with HasGameReference<GameScene> {
  NebulaeDustBackground() : super(postProcess: NebulaePostProcess());

  @override
  Future<void> onLoad() async {
    size = game.size;
    postProcess.world = game.world;
    await super.onLoad();
  }
}
