import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:watch_it/watch_it.dart';

import '../../../../../main.dart';
import '../../../../entities/level/level.dart';
import '../../../components/buttons/rectangle_button.dart';
import '../../../components/texts/text_large.dart';
import '../../levels/controllers/level_state.dart';
import '../../main_menu/main_menu_page.dart';
import '../controllers/game_controller.dart';
import '../controllers/game_state.dart';
import 'glass_container.dart';

class WinDialog extends WatchingWidget {
  WinDialog({
    super.key,
    required this.game,
  });

  final Game game;

  static final overlayName = 'win_dialog';
  final levelState = locator.get<LevelState>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final level = watchPropertyValue(
      (GameState state) => state.level,
    );

    return Stack(
      children: [
        Positioned.fill(
          child: Container(
            color: Colors.black.withValues(alpha: 0.6),
          ).animate().fadeIn(),
        ),
        Center(
          child: GlassContainer(
            width: (size.width * 0.4).clamp(0, 200),
            padding: EdgeInsets.all(24),
            color: level.background.color,
            child: _buildContent(level, context),
          ).animateDialogAppear,
        ),
      ],
    );
  }

  Widget _buildContent(Level level, BuildContext context) {
    return Column(
      spacing: 32,
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        TextLarge(
          'Mission\nSuccess!',
          color: Colors.white,
          textAlign: TextAlign.center,
        ),
        _buildButtons(level, context)
      ],
    ).animateContentAppear;
  }

  Widget _buildButtons(Level level, BuildContext context) {
    return Column(
      spacing: 12,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (level.level < levelState.levels.length)
          RectangleButton(
            color: level.background.color,
            width: 90,
            text: 'Next Level',
            onTap: () {
              final gameController = locator.get<GameController>();
              gameController.nextLevel();
            },
          ),
        RectangleButton(
          color: Colors.red,
          width: 90,
          text: 'Main Menu',
          onTap: () => context.go(MainMenuPage.routeName),
        ),
      ],
    );
  }
}

extension WinDialogAnimation on Widget {
  Widget get animateContentAppear {
    return animate(
      delay: 0.5.seconds,
    ).fadeIn(
      duration: 0.1.seconds,
      curve: Curves.fastOutSlowIn,
    );
  }

  Widget get animateDialogAppear {
    return animate().scaleY(
      duration: 0.5.seconds,
      curve: Curves.fastOutSlowIn,
    );
  }
}
