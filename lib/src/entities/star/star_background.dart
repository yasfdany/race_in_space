import 'package:flame/components.dart';

import '../../ui/scenes/game/game_scene.dart';
import '../../utils/helpers/random_helper.dart';
import 'big_star.dart';
import 'small_star.dart';

class StarBackground extends PositionComponent
    with HasGameReference<GameScene> {
  late final smallStars = List.generate(30, (i) {
    final x = RandomHelper.rangeDouble(
      min: 0,
      max: game.size.x,
    );
    final y = RandomHelper.rangeDouble(
      min: 0,
      max: game.size.y,
    );
    return SmallStar(position: Vector2(x, y));
  });
  late final bigStars = List.generate(10, (i) {
    final x = RandomHelper.rangeDouble(
      min: 0,
      max: game.size.x,
    );
    final y = RandomHelper.rangeDouble(
      min: 0,
      max: game.size.y,
    );
    return BigStar(position: Vector2(x, y));
  });

  @override
  void onLoad() {
    size = game.size;
    position = -size / 2;
    addAll(smallStars);
    addAll(bigStars);
  }
}
