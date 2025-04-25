import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:text_gradiate/text_gradiate.dart';

import '../../../../resources/app_text_styles.dart';

class TextLogo extends StatelessWidget {
  const TextLogo(
    this.text, {
    super.key,
    this.fontSize = 86,
    this.color = Colors.indigo,
  });

  final String text;
  final double fontSize;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Text(
          text,
          textAlign: TextAlign.center,
          style: defaultStyle.copyWith(
            shadows: [
              Shadow(
                color: color.darken(50),
                offset: Offset(0, 4),
                blurRadius: 0,
              ),
            ],
          ),
        ),
        TextGradiate(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            color.lighten(80),
            color.lighten(20),
            color,
          ],
          stops: [
            0.1,
            0.55,
            0.55,
          ],
          text: Text(
            text,
            textAlign: TextAlign.center,
            style: defaultStyle,
          ),
        ),
      ],
    );
  }

  TextStyle get defaultStyle => AppTextStyles.regularL.copyWith(
        height: 0.8,
        fontSize: fontSize,
        fontWeight: FontWeight.bold,
        fontFamily: 'at01',
        letterSpacing: 4,
      );
}
