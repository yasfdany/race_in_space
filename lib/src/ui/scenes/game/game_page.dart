import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import '../../../../main.dart';
import 'controllers/game_controller.dart';
import 'controllers/game_state.dart';
import 'game_scene.dart';

class GamePage extends StatefulWidget {
  const GamePage({super.key});

  static const String routeName = '/game';

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  final game = GameScene();
  late final GameState state;
  late final GameController controller;

  @override
  void initState() {
    super.initState();
    state = registerOnce<GameState>(
      GameState(),
    );
    controller = registerOnce<GameController>(
      GameController(state),
    );
  }

  @override
  void dispose() {
    locator.unregister<GameState>(
      instance: state,
    );
    locator.unregister<GameController>(
      instance: controller,
    );
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: GameWidget<GameScene>(
        game: game,
        initialActiveOverlays: [],
        overlayBuilderMap: {},
      ),
    );
  }
}
