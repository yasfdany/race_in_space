import 'package:flame/components.dart';
import 'package:flame/post_process.dart';

import '../../ui/scenes/game/game_scene.dart';
import 'post_process/gas_planet_post_process.dart';

class GasPlanet extends PostProcessComponent<GasPlanetPostProcess>
    with HasGameReference<GameScene> {
  GasPlanet({
    required super.size,
  }) : super(postProcess: GasPlanetPostProcess());

  @override
  Future<void> onLoad() async {
    postProcess.world = game.world;
    await super.onLoad();
  }
}
