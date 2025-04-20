import 'package:flame/events.dart';
import 'package:flame_behaviors/flame_behaviors.dart';

import '../gravitation_area.dart';

class DragBehavior extends DraggableBehavior<GravitationArea> {
  @override
  void onDragUpdate(DragUpdateEvent event) {
    parent.position.add(event.localDelta);
  }
}
