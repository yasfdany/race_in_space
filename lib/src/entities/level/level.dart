import 'package:flame/components.dart';

class Level {
  String name;
  int level;
  World world;
  int solar;
  int attempts;
  int star;
  double zoom;
  bool canZoom;
  Vector2 startingPos;

  Level({
    required this.name,
    required this.level,
    required this.world,
    required this.startingPos,
    this.solar = 6,
    this.attempts = 3,
    this.star = 0,
    this.zoom = 1,
    this.canZoom = true,
  });
}
