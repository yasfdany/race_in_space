import 'package:flame/components.dart';
import 'package:flame/post_process.dart';

import '../../ui/scenes/game/game_scene.dart';
import 'post_process/dry_planet_post_process.dart';

class DryPlanet extends PostProcessComponent<DryPlanetPostProcess>
    with HasGameReference<GameScene> {
  DryPlanet({
    required super.size,
  }) : super(postProcess: DryPlanetPostProcess());

  @override
  Future<void> onLoad() async {
    postProcess.world = game.world;
    await super.onLoad();
  }
}
