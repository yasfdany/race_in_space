import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../components/texts/text.dart';
import '../intro/intro_page.dart';

class InteractionPage extends StatelessWidget {
  const InteractionPage({super.key});

  static const String routeName = '/interaction';

  @override
  Widget build(BuildContext context) {
    return Material(
      child: GestureDetector(
        onTap: () => context.go(IntroPage.routeName),
        child: Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.black,
          alignment: Alignment.center,
          child: TextLarge('Tap anywhere to start'),
        ),
      ),
    );
  }
}
