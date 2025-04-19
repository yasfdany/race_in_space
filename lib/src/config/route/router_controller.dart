import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../ui/scenes/game/game_page.dart';
import '../../ui/scenes/levels/level_page.dart';
import '../../ui/scenes/main_menu/main_menu_page.dart';

final navigatorKey = GlobalKey<NavigatorState>();

final router = GoRouter(
  navigatorKey: navigatorKey,
  debugLogDiagnostics: true,
  initialLocation: MainMenuPage.routeName,
  routes: [
    GoRoute(
      path: MainMenuPage.routeName,
      builder: (context, state) {
        return MainMenuPage();
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
  ], // All the routes can be found there
);
