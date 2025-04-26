import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../../main.dart';
import '../../../../../r.dart';
import '../../../../utils/extensions/widget_ext.dart';
import '../../../components/texts/text.dart';
import '../controllers/game_state.dart';

class TutorialOverlay extends StatefulWidget {
  const TutorialOverlay({
    super.key,
    required this.game,
  });

  final Game game;
  static final overlayName = 'tutorial_overlay';

  @override
  State<TutorialOverlay> createState() => _TutorialOverlayState();
}

class _TutorialOverlayState extends State<TutorialOverlay> {
  final gameState = locator.get<GameState>();
  AnimationController? controller;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Stack(
      children: [
        Positioned.fill(
          child: Container(
            color: Colors.black.withValues(alpha: 0.6),
          ).animate().fadeIn(),
        ),
        Animate(
          onPlay: (c) {
            c.repeat();
            setState(() {
              controller = c;
            });
          },
          effects: [
            FadeEffect(
              curve: Curves.easeInOut,
              duration: 0.5.seconds,
              begin: 0,
              end: 1,
            ),
            MoveEffect(
              curve: Curves.easeInOut,
              duration: 1.seconds,
              end: Offset(0, 80),
            ),
            ThenEffect(),
            FadeEffect(
              delay: 1.seconds,
              curve: Curves.easeInOut,
              duration: 0.5.seconds,
              end: 0,
            ),
          ],
          child: Positioned(
            left: (size.width / 2) + gameState.level.startingPos.x - 12,
            top: (size.height / 2) + gameState.level.startingPos.y,
            child: Row(
              spacing: 8,
              children: [
                Image.asset(
                  AssetImages.hand,
                  width: 32,
                  filterQuality: FilterQuality.none,
                ),
                if (controller != null)
                  AnimatedBuilder(
                    animation: controller!,
                    builder: (_, __) {
                      return TextMedium(
                        controller!.value > 0.6
                            ? 'Release to launch!'
                            : 'Drag to aim',
                      );
                    },
                  )
              ],
            ),
          ),
        ),
      ],
    ).ignorePointer;
  }
}
