import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:watch_it/watch_it.dart';

import '../../../../main.dart';
import '../../../entities/level/level.dart';
import '../../components/texts/text_medium.dart';
import '../../components/texts/text_small.dart';
import '../game/controllers/game_state.dart';
import '../game/game_page.dart';
import '../main_menu/main_menu_page.dart';
import 'controllers/level_state.dart';

class LevelPage extends WatchingStatefulWidget {
  const LevelPage({super.key});

  static const String routeName = 'levels';
  static const String route = '${MainMenuPage.routeName}/$routeName';

  @override
  State<LevelPage> createState() => _LevelPageState();
}

class _LevelPageState extends State<LevelPage> {
  late LevelState state;

  @override
  void initState() {
    super.initState();
    state = registerOnce<LevelState>(LevelState());
  }

  @override
  Widget build(BuildContext context) {
    final levels = watchPropertyValue((LevelState state) => state.levels);

    return GridView.builder(
      padding: EdgeInsets.all(12),
      itemCount: levels.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: 1,
      ),
      itemBuilder: (BuildContext context, int index) {
        final level = levels[index];
        return _buildLevelCard(context, level);
      },
    );
  }

  Widget _buildLevelCard(BuildContext context, Level level) {
    return GestureDetector(
      onTap: () {
        final state = registerOnce<GameState>(
          GameState(),
        );
        state.level = level;
        context.go(GamePage.routeName);
      },
      child: Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextMedium.bold(
              level.name,
              color: Colors.black,
            ),
            TextSmall(
              'Level ${level.level}',
              color: Colors.black,
            ),
          ],
        ),
      ),
    );
  }
}
