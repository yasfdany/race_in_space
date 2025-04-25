import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:watch_it/watch_it.dart';

import '../../../../main.dart';
import '../../../config/di/get_it_ext.dart';
import '../../../entities/level/level.dart';
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
  late final shaderController = locator.shaderController;
  late LevelState state;

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
          GameWidget(game: MainMenuBackground()),
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
              final scale = 1 + (level.solar / 40);
              return Center(
                child: PopButton(
                  onTap: () => _startLevel(context, level),
                  child: Column(
                    spacing: 24,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: level.spaceColor,
                            width: 2,
                          ),
                          shape: BoxShape.circle,
                        ),
                        child: PlanetWidget(
                          width: 100 * scale,
                          height: 100 * scale,
                          baseColor: level.spaceColor,
                          shader: shaderController.dryPlanetShader,
                        ),
                      )
                          .animate(
                            delay: (index * 100).ms,
                          )
                          .scaleXY(
                            duration: 300.ms,
                            curve: Curves.fastOutSlowIn,
                          ),
                      TextMedium(level.name)
                          .animate(
                            delay: (index * 200).ms,
                          )
                          .slideY(
                            begin: -2,
                            end: 0,
                            duration: 300.ms,
                            curve: Curves.fastOutSlowIn,
                          )
                          .fadeIn(),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );

    // return GridView.builder(
    //   padding: EdgeInsets.all(12),
    //   itemCount: levels.length,
    //   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
    //     crossAxisCount: 3,
    //     mainAxisSpacing: 12,
    //     crossAxisSpacing: 12,
    //     childAspectRatio: 1,
    //   ),
    //   itemBuilder: (BuildContext context, int index) {
    //     final level = levels[index];
    //     return _buildLevelCard(context, level);
    //   },
    // );
  }

  // Widget _buildLevelCard(BuildContext context, Level level) {
  //   return GestureDetector(
  //     onTap: () {
  //       _startLevel(level, context);
  //     },
  //     child: Card(
  //       child: Column(
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         children: [
  //           TextMedium.bold(
  //             level.name,
  //             color: Colors.black,
  //           ),
  //           TextSmall(
  //             'Level ${level.level}',
  //             color: Colors.black,
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  void _startLevel(BuildContext context, Level level) {
    final state = registerOnce<GameState>(
      GameState(),
    );
    state.level = level;
    context.go(GamePage.routeName);
  }
}
