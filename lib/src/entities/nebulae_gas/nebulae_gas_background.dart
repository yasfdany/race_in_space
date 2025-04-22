import 'package:flame/components.dart';
import 'package:flame/post_process.dart';

import '../../ui/scenes/game/game_scene.dart';
import 'post_process/nebulae_gas_process.dart';

class NebulaeGasBackground extends PostProcessComponent<NebulaeGasPostProcess>
    with HasGameReference<GameScene> {
  NebulaeGasBackground() : super(postProcess: NebulaeGasPostProcess());

  @override
  Future<void> onLoad() async {
    size = game.size;
    postProcess.world = game.world;
    await super.onLoad();
  }
}
