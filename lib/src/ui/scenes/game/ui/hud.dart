import 'package:awesome_extensions/awesome_extensions_flutter.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:gap/gap.dart';
import 'package:watch_it/watch_it.dart';

import '../../../../../main.dart';
import '../../../../../r.dart';
import '../../../components/buttons/pop_button.dart';
import '../controllers/game_controller.dart';
import '../controllers/game_state.dart';

class Hud extends WatchingWidget {
  Hud({
    super.key,
    required this.game,
  });

  final Game game;
  static final overlayName = 'hud';
  final gameState = locator<GameState>();
  final gameController = locator<GameController>();

  @override
  Widget build(BuildContext context) {
    final attempts = watchPropertyValue((GameState state) => state.attempts);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        PopButton(
          onTap: gameController.pauseGame,
          child: Container(
            color: Colors.transparent,
            padding: EdgeInsets.all(19),
            child: Image.asset(
              AssetImages.pause,
              filterQuality: FilterQuality.none,
              width: 18,
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (var i = 0; i < gameState.level.attempts; i++)
              Image.asset(
                AssetImages.rocket,
                width: 32,
                filterQuality: FilterQuality.none,
              )
                  .animate(target: attempts <= i ? 1 : 0)
                  .shake(
                    duration: 0.3.seconds,
                    curve: Curves.fastOutSlowIn,
                    rotation: 0.2,
                    hz: 4,
                  )
                  .then()
                  .fade(
                    end: 0.5,
                  ),
          ],
        ),
        Gap(56),
      ],
    ).paddingVertical(12);
  }
}
