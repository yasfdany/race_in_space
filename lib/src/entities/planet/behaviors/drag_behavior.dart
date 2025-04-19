import 'package:flame/events.dart';
import 'package:flame_behaviors/flame_behaviors.dart';

import '../planet.dart';

class DragBehavior extends DraggableBehavior<Planet> {
  @override
  void onDragUpdate(DragUpdateEvent event) {
    parent.position.add(event.localDelta);
  }
}
