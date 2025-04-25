import 'package:flame/game.dart' show GameWidget;
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../../main.dart';
import '../../../../r.dart';
import '../../../config/di/get_it_ext.dart';
import '../../../utils/extensions/widget_ext.dart';
import '../../components/buttons/pop_button.dart';
import '../../components/buttons/rectangle_button.dart';
import '../levels/level_page.dart';
import 'component/text_logo.dart';
import 'controllers/main_menu_controller.dart';
import 'main_menu_background.dart';

class MainMenuPage extends StatefulWidget {
  const MainMenuPage({super.key});

  static const String routeName = '/main_menu';

  @override
  State<MainMenuPage> createState() => _MainMenuPageState();
}

class _MainMenuPageState extends State<MainMenuPage>
    with SingleTickerProviderStateMixin {
  late final AnimationController animationController;
  late final Animation<double> skewAnimation;

  late final background = MainMenuBackground();
  late final controller = registerOnce<MainMenuController>(
    MainMenuController(),
  );

  final socials = [
    (AssetImages.twitter, 'https://x.com/yasfdany'),
    (AssetImages.instagram, 'https://www.instagram.com/yasfdany/'),
    (AssetImages.github, 'https://github.com/yasfdany'),
    (AssetImages.linkedin, 'https://www.linkedin.com/in/yasfdany/'),
  ];

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: 3.seconds,
    )..repeat(reverse: true);

    skewAnimation = Tween(
      begin: -0.1,
      end: 0.1,
    ).animate(CurvedAnimation(
      parent: animationController,
      curve: Curves.easeInOut,
    ));

    locator.audioController.init();
  }

  @override
  void dispose() {
    animationController.dispose();
    locator.unregister<MainMenuController>(
      instance: controller,
    );
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
        children: [
          GameWidget(game: background),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildLogo(),
                Gap(32),
                RectangleButton(
                  onTap: () => context.go(LevelPage.route),
                  text: 'Start',
                  width: 100,
                  height: 30,
                  color: background.currentColor,
                ),
                Gap(42),
                _buildSocialButtons(),
              ],
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

  Widget _buildSocialButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: socials.map((social) => _buildSocialButton(social)).toList(),
    );
  }

  Widget _buildSocialButton((String, String) social) {
    return PopButton(
      onTap: () => launchUrlString(
        social.$2,
        mode: LaunchMode.externalApplication,
      ),
      child: Container(
        color: Colors.transparent,
        padding: EdgeInsets.all(12),
        child: Image.asset(
          social.$1,
          width: 24,
          filterQuality: FilterQuality.none,
        ),
      ),
    );
  }

  AnimatedBuilder _buildLogo() {
    return AnimatedBuilder(
      animation: animationController,
      builder: (_, __) {
        return Transform(
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.004)
            ..rotateY(skewAnimation.value)
            ..rotateZ(skewAnimation.value / 5)
            ..rotateX(-0.5),
          alignment: Alignment.center,
          child: Column(
            children: [
              TextLogo(
                'SPACE',
                fontSize: 80,
                color: background.currentColor,
              ),
              TextLogo(
                'RACE',
                fontSize: 60,
                color: background.currentColor,
              ),
            ],
          ),
        );
      },
    );
  }
}
