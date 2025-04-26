import 'package:flame/events.dart';
import 'package:flame_behaviors/flame_behaviors.dart';
import 'package:flutter/foundation.dart';

import '../asteroid.dart';

class DragBehavior extends DraggableBehavior<Asteroid> {
  @override
  void onDragUpdate(DragUpdateEvent event) {
    parent.position.add(event.localDelta);
    debugPrint(parent.position.toString());
  }
}
