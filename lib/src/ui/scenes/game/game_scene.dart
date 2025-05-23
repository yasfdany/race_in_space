import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame_behaviors/flame_behaviors.dart';
import 'package:flutter/foundation.dart';

import '../../../../main.dart';
import '../../../resources/app_text_styles.dart';
import 'controllers/game_controller.dart';

class GameScene extends FlameGame with EntityMixin, HasCollisionDetection {
  // ScrollDetector, ScaleDetector {
  late final controller = locator.get<GameController>();
  static const zoomPerScrollUnit = 0.02;
  // late double startZoom;

  @override
  void onLoad() async {
    camera = CameraComponent.withFixedResolution(
      width: size.x,
      height: size.y,
    );
    world = controller.state.level.world;
    camera.viewfinder.zoom = controller.state.level.zoom;

    if (kDebugMode) {
      add(FpsTextComponent(
        textRenderer: TextPaint(
          style: AppTextStyles.regularM,
        ),
        position: Vector2(10, 10),
      ));
    }
  }

  // @override
  // void onScroll(PointerScrollInfo info) {
  //   if (!controller.state.level.canZoom) return;
  //   camera.viewfinder.zoom +=
  //       info.scrollDelta.global.y.sign * zoomPerScrollUnit;

  //   clampZoom();
  // }

  // @override
  // void onScaleStart(ScaleStartInfo info) {
  //   if (!controller.state.level.canZoom) return;
  //   startZoom = camera.viewfinder.zoom;
  // }

  // @override
  // void onScaleUpdate(ScaleUpdateInfo info) {
  //   if (!controller.state.level.canZoom) return;
  //   final currentScale = info.scale.global;
  //   if (!currentScale.isIdentity()) {
  //     camera.viewfinder.zoom = startZoom * currentScale.y;
  //     clampZoom();
  //   } else {
  //     final delta = info.delta.global;
  //     camera.viewfinder.position.translate(-delta.x, -delta.y);
  //   }
  // }

  // void clampZoom() {
  //   camera.viewfinder.zoom = camera.viewfinder.zoom.clamp(0.05, 3.0);
  // }
}
