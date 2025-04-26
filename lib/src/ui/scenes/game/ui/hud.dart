import 'package:awesome_extensions/awesome_extensions_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:watch_it/watch_it.dart';

import '../../../../../main.dart';
import '../../../../../r.dart';
import '../controllers/game_state.dart';

class Hud extends WatchingWidget {
  Hud({super.key});

  static final overlayName = 'hud';
  final gameState = locator<GameState>();

  @override
  Widget build(BuildContext context) {
    final attempts = watchPropertyValue((GameState state) => state.attempts);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (var i = 0; i < gameState.level.attempts; i++)
          Image.asset(
            AssetImages.rocket,
            width: 38,
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
    ).paddingAll(32);
  }
}
