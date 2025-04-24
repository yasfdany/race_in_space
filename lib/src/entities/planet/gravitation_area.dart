import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flame/geometry.dart';
import 'package:flame_behaviors/flame_behaviors.dart';

import '../../../main.dart';
import '../../ui/scenes/game/controllers/game_controller.dart';
import '../../ui/scenes/game/game_scene.dart';
import '../../utils/helpers/random_helper.dart';
import 'behaviors/gravity_behavior.dart';
import 'planet.dart';
import 'shaders/gravitation_area_shader.dart';

class GravitationArea extends PositionedEntity
    with HasGameReference<GameScene> {
  GravitationArea({
    this.radius = 0,
    super.position,
    super.anchor = Anchor.center,
  }) : super(behaviors: _buildBehaviors);

  late final controller = locator.get<GameController>();
  double radius;

  static List<Behavior<EntityMixin>> get _buildBehaviors {
    return [
      PropagatingCollisionBehavior(CircleHitbox()),
      GravityBehavior(),
    ];
  }

  @override
  void onLoad() {
    size = Vector2.all(radius * 2);
    angle = RandomHelper.rangeDouble(
      min: -tau,
      max: tau,
    );
    add(GravitationAreaShader(
      size: size,
      color: controller.state.level.background.color.darken(0.8),
    ));
  }

  Planet get planet => parent as Planet;
}
