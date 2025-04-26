import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:watch_it/watch_it.dart';

import '../../../../main.dart';
import '../../../../r.dart';
import '../../../config/di/get_it_ext.dart';
import '../../../entities/level/level.dart';
import '../../../utils/extensions/widget_ext.dart';
import '../../components/buttons/pop_button.dart';
import '../../components/texts/text_medium.dart';
import '../game/controllers/game_state.dart';
import '../game/game_page.dart';
import '../main_menu/main_menu_background.dart';
import '../main_menu/main_menu_page.dart';
import 'components/dry_planet_widget.dart';
import 'controllers/level_state.dart';

class LevelPage extends WatchingStatefulWidget {
  const LevelPage({super.key});

  static const String routeName = 'levels';
  static const String route = '${MainMenuPage.routeName}/$routeName';

  @override
  State<LevelPage> createState() => _LevelPageState();
}

class _LevelPageState extends State<LevelPage> {
  final background = MainMenuBackground();
  late final shaderController = locator.shaderController;
  late LevelState state;

  final lastLevel = locator.prefHelper.lastLevel;

  @override
  void initState() {
    super.initState();
    state = registerOnce<LevelState>(LevelState());
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final levels = watchPropertyValue((LevelState state) => state.levels);

    return Material(
      child: Stack(
        children: [
          GameWidget(game: background),
          ListView.separated(
            reverse: true,
            physics: BouncingScrollPhysics(),
            padding: EdgeInsets.symmetric(
              vertical: size.height / 3,
            ),
            itemCount: levels.length,
            separatorBuilder: (_, __) => Gap(50),
            itemBuilder: (context, index) {
              final level = levels[index];
              return _buildPlanet(context, level, index);
            },
          ),
          Align(
            alignment: Alignment.topLeft,
            child: PopButton(
              onTap: context.pop,
              child: Container(
                color: Colors.transparent,
                padding: EdgeInsets.all(24),
                child: Image.asset(
                  AssetImages.back,
                  filterQuality: FilterQuality.none,
                  width: 32,
                ),
              ),
            ),
          ),
          Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.black,
          ).ignorePointer.animate().fadeOut(duration: 0.5.seconds),
        ],
      ),
    );
  }

  Widget _buildPlanet(BuildContext context, Level level, int index) {
    final scale = 1 + (level.solar / 40);
    final isLevelLocked = lastLevel < level.level;

    return Center(
      child: PopButton(
        disabled: isLevelLocked,
        onTap: () => _startLevel(context, level),
        child: Column(
          spacing: 24,
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: isLevelLocked ? Colors.grey : level.spaceColor,
                  width: 2,
                ),
                shape: BoxShape.circle,
              ),
              child: PlanetWidget(
                width: 100 * scale,
                height: 100 * scale,
                baseColor: isLevelLocked ? Colors.grey : level.spaceColor,
                shader: shaderController.dryPlanetShader,
              ),
            ),
            TextMedium(
              level.name,
              color: isLevelLocked ? Colors.grey : Colors.white,
            ),
          ],
        ).animate(delay: (index * 100).ms).scaleXY(
              duration: 500.ms,
              curve: Curves.fastOutSlowIn,
            ),
      ),
    );
  }

  void _startLevel(BuildContext context, Level level) {
    final state = registerOnce<GameState>(
      GameState(),
    );
    state.level = level;
    context.go(GamePage.routeName);
  }
}
