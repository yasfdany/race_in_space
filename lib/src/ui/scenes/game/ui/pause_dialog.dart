import 'package:flame/game.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:watch_it/watch_it.dart';

import '../../../../../main.dart';
import '../../../../config/di/get_it_ext.dart';
import '../../../../entities/level/level.dart';
import '../../../components/buttons/rectangle_button.dart';
import '../../../components/texts/text_large.dart';
import '../../main_menu/main_menu_page.dart';
import '../controllers/game_state.dart';
import 'glass_container.dart';

class PauseDialog extends WatchingStatefulWidget {
  const PauseDialog({
    super.key,
    required this.game,
  });

  final Game game;

  static final overlayName = 'pause_dialog';

  @override
  State<PauseDialog> createState() => _PauseDialogState();
}

class _PauseDialogState extends State<PauseDialog> {
  final audioController = locator.audioController;
  bool open = true;

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
          ).animate(target: open ? 1 : 0).fadeIn(),
        ),
        Center(
          child: GlassContainer(
            width: (size.width * 0.4).clamp(0, 200),
            padding: EdgeInsets.all(24),
            color: level.background.color,
            child: _buildContent(level, context),
          ).animateDialogAppear(open),
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
          'Pause Game',
          color: Colors.white,
          textAlign: TextAlign.center,
        ),
        _buildButtons(level, context)
      ],
    )
        .animateContentAppear
        .animate(
          target: !open ? 1 : 0,
        )
        .fadeOut(
          duration: 0.3.seconds,
          curve: Curves.fastOutSlowIn,
        );
  }

  Widget _buildButtons(Level level, BuildContext context) {
    return Column(
      spacing: 12,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        RectangleButton(
          color: level.background.color,
          width: 90,
          text: 'Resume',
          onTap: () async {
            audioController.resumeAll();
            FlameAudio.bgm.resume();
            widget.game.resumeEngine();
            setState(() {
              open = false;
            });
            await Future.delayed(0.5.seconds);
            widget.game.overlays.remove(PauseDialog.overlayName);
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

extension PauseDialogAnimation on Widget {
  Widget get animateContentAppear {
    return animate(
      delay: 0.5.seconds,
    ).fadeIn(
      duration: 0.3.seconds,
      curve: Curves.fastOutSlowIn,
    );
  }

  Widget animateDialogAppear(bool open) {
    return animate(target: open ? 1 : 0).scaleY(
      duration: 0.5.seconds,
      curve: Curves.fastOutSlowIn,
    );
  }
}
