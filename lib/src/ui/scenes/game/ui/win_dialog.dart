import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../../main.dart';
import '../../../components/buttons/rectangle_button.dart';
import '../../../components/texts/text_large.dart';
import '../../main_menu/main_menu_page.dart';
import '../controllers/game_controller.dart';

class WinDialog extends StatelessWidget {
  const WinDialog({
    super.key,
    required this.game,
  });

  final Game game;

  static final overlayName = 'win_dialog';

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Container(
            color: Colors.black.withValues(alpha: 0.5),
          ),
        ),
        Center(
          child: Container(
            padding: EdgeInsets.all(24),
            width: 0.6.sw.clamp(0, 400),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              spacing: 12,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                TextLarge.bold('You win!', color: Colors.black),
                Row(
                  spacing: 12,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RectangleButton(
                      text: 'Main Menu',
                      onTap: () => context.go(MainMenuPage.routeName),
                    ),
                    RectangleButton(
                      text: 'Next Level',
                      onTap: () {
                        final gameController = locator.get<GameController>();
                        gameController.nextLevel();
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
