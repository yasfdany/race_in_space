import 'package:flame/game.dart' as game;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';

import '../../../../main.dart';
import '../../../config/di/get_it_ext.dart';
import '../../../utils/extensions/widget_ext.dart';
import '../../components/texts/text_large.dart';
import '../main_menu/main_menu_background.dart';
import '../main_menu/main_menu_page.dart';

class StoryPage extends StatefulWidget {
  const StoryPage({super.key});

  static const String routeName = '/story';

  @override
  StoryPageState createState() => StoryPageState();
}

class StoryPageState extends State<StoryPage>
    with SingleTickerProviderStateMixin {
  final background = MainMenuBackground();

  late final audioController = locator.audioController;
  late AnimationController controller;
  Animation<double>? animation;

  bool fadeOut = true;
  double narratorPos = -100;

  @override
  void initState() {
    super.initState();
    Future.delayed(1.seconds, () {
      audioController.playNarrator();
    });

    controller = AnimationController(
      vsync: this,
      duration: 1.minutes,
    )..forward();

    SchedulerBinding.instance.addPostFrameCallback((_) {
      animation = Tween<double>(
        begin: 1,
        end: -1,
      ).animate(
        CurvedAnimation(
          parent: controller,
          curve: Curves.linear,
        ),
      );
    });

    Future.delayed(25.seconds, () async {
      locator.prefHelper.storyShown = true;
      audioController.stopNarrator();
      setState(() {
        fadeOut = false;
      });
      await Future.delayed(1.seconds);
      if (mounted) {
        context.go(MainMenuPage.routeName);
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          game.GameWidget(game: background),
          Center(
            child: AnimatedBuilder(
              animation: controller,
              builder: (context, child) {
                final value = (animation?.value ?? 1) * (size.height / 2);

                return Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.identity()
                    ..setEntry(3, 2, 0.002)
                    ..rotateX(-0.6)
                    ..translate(0.0, value),
                  child: child,
                );
              },
              child: SizedBox(
                width: 300,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  spacing: 24,
                  children: [
                    TextLarge(
                      'History repeats itself.\nA Second Cold War ignites, not on Earth but among the stars.',
                      textAlign: TextAlign.center,
                    ),
                    TextLarge(
                      "The world's powers race to Gargantua, desperate to uncover the ultimate truth hidden beyond the stars.",
                      textAlign: TextAlign.center,
                    ),
                    TextLarge(
                      'Fuel will fail you. Only orbital jumps can lead you to salvation.',
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ),
          _buildOverlay()
              .ignorePointer
              .animate(target: fadeOut ? 1 : 0)
              .fadeOut(duration: 0.5.seconds),
        ],
      ),
    );
  }

  Widget _buildOverlay() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.black,
    );
  }
}
