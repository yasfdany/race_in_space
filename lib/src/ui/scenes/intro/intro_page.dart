import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';

import '../../../../r.dart';
import '../../../config/di/get_it_config.dart';
import '../../components/texts/text_medium.dart';
import '../main_menu/main_menu_page.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({super.key});

  static const String routeName = '/intro';

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  bool fadeOut = false;

  @override
  void initState() {
    super.initState();
    initResources();
  }

  void initResources() async {
    await GetItConfig.register();
    await Future.delayed(1.seconds);
    setState(() {
      fadeOut = true;
    });
    await Future.delayed(1.seconds);
    if (mounted) context.go(MainMenuPage.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.black,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 12,
          children: [
            Image.asset(
              AssetImages.headphone,
              width: 32,
              height: 32,
              filterQuality: FilterQuality.none,
            ).animateHover,
            TextMedium(
              'Use headphones for the best experience',
            ),
          ],
        ).animateIntro(fadeOut),
      ),
    );
  }
}

extension IntroAnimation on Widget {
  Widget animateIntro(bool fadeOut) {
    return animate()
        .fadeIn(duration: 0.5.seconds)
        .animate(target: fadeOut ? 1 : 0)
        .fadeOut(duration: 0.5.seconds);
  }

  Widget get animateHover {
    return Animate(
      onPlay: (c) => c.repeat(),
      effects: [
        SlideEffect(
          begin: const Offset(0, 0.2),
          end: const Offset(0, 0),
          duration: 1.seconds,
          curve: Curves.easeInOut,
        ),
        ThenEffect(),
        SlideEffect(
          begin: const Offset(0, -0.2),
          end: const Offset(0, 0),
          duration: 1.seconds,
          curve: Curves.easeInOut,
        ),
      ],
      child: this,
    );
  }
}
