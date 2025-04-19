import 'package:flame/components.dart';

class Level {
  String name;
  int level;
  List<Component> entities;
  int attempts;
  int star;
  double zoom;
  bool canZoom;

  Level({
    required this.name,
    required this.level,
    required this.entities,
    this.attempts = 3,
    this.star = 0,
    this.zoom = 1,
    this.canZoom = true,
  });
}
