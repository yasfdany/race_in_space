import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../main.dart';
import '../../../utils/extensions/widget_ext.dart';
import 'controllers/game_controller.dart';
import 'controllers/game_state.dart';
import 'game_scene.dart';
import 'ui/hud.dart';
import 'ui/win_dialog.dart';

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
      GameController(state, game),
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
        initialActiveOverlays: [
          Hud.overlayName,
          'dark_overlay',
        ],
        overlayBuilderMap: {
          WinDialog.overlayName: (context, game) {
            return WinDialog(game: game);
          },
          Hud.overlayName: (context, game) {
            return Hud();
          },
          'dark_overlay': (context, game) {
            return Container(
              width: double.infinity,
              height: double.infinity,
              color: Colors.black,
            ).ignorePointer.animate().fadeOut(duration: 0.5.seconds);
          },
        },
      ),
    );
  }
}
