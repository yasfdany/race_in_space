import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../main.dart';
import '../../components/texts/text_large.dart';
import '../levels/level_page.dart';
import 'controllers/main_menu_controller.dart';

class MainMenuPage extends StatefulWidget {
  const MainMenuPage({super.key});

  static const String routeName = '/main_menu';

  @override
  State<MainMenuPage> createState() => _MainMenuPageState();
}

class _MainMenuPageState extends State<MainMenuPage> {
  late final controller = registerOnce<MainMenuController>(
    MainMenuController(),
  );

  @override
  void dispose() {
    locator.unregister<MainMenuController>(
      instance: controller,
    );
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.red,
      child: TextButton(
        onPressed: () => context.push(LevelPage.route),
        child: TextLarge.bold('Play'),
      ),
    );
  }
}
