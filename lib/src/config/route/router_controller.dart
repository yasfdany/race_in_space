import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../ui/scenes/game/game_page.dart';
import '../../ui/scenes/interaction/interaction_page.dart';
import '../../ui/scenes/intro/intro_page.dart';
import '../../ui/scenes/levels/level_page.dart';
import '../../ui/scenes/main_menu/main_menu_page.dart';
import '../../ui/scenes/story/story_page.dart';

final navigatorKey = GlobalKey<NavigatorState>();

final router = GoRouter(
  navigatorKey: navigatorKey,
  debugLogDiagnostics: true,
  initialLocation: kIsWeb ? InteractionPage.routeName : IntroPage.routeName,
  routes: [
    GoRoute(
      path: IntroPage.routeName,
      pageBuilder: (BuildContext context, GoRouterState state) {
        return NoTransitionPage(
          child: IntroPage(),
        );
      },
    ),
    GoRoute(
      path: StoryPage.routeName,
      pageBuilder: (BuildContext context, GoRouterState state) {
        return NoTransitionPage(
          child: StoryPage(),
        );
      },
    ),
    GoRoute(
      path: InteractionPage.routeName,
      pageBuilder: (BuildContext context, GoRouterState state) {
        return NoTransitionPage(
          child: InteractionPage(),
        );
      },
    ),
    GoRoute(
      path: MainMenuPage.routeName,
      pageBuilder: (BuildContext context, GoRouterState state) {
        return NoTransitionPage(
          child: MainMenuPage(),
        );
      },
      routes: [
        GoRoute(
          path: LevelPage.routeName,
          pageBuilder: (BuildContext context, GoRouterState state) {
            return NoTransitionPage(
              child: LevelPage(),
            );
          },
        ),
      ],
    ),
    GoRoute(
      path: GamePage.routeName,
      pageBuilder: (BuildContext context, GoRouterState state) {
        return NoTransitionPage(
          child: GamePage(),
        );
      },
    ),
  ],
);
