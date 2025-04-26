import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:watch_it/watch_it.dart';

import '../../../../../main.dart';
import '../../../../entities/level/level.dart';
import '../../../components/buttons/rectangle_button.dart';
import '../../../components/texts/text_large.dart';
import '../../main_menu/main_menu_page.dart';
import '../controllers/game_controller.dart';
import '../controllers/game_state.dart';
import 'glass_container.dart';

class LoseDialog extends WatchingWidget {
  const LoseDialog({
    super.key,
    required this.game,
  });

  final Game game;

  static final overlayName = 'lose_dialog';

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
            color: Colors.red,
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
          'Mission\nFailed!',
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
        RectangleButton(
          color: Color.fromARGB(255, 22, 139, 112),
          width: 90,
          text: 'Retry',
          onTap: () {
            final gameController = locator.get<GameController>();
            gameController.retryLevel();
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

extension LoseDialogAnimation on Widget {
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
