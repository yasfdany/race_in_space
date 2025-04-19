import 'package:flutter/widgets.dart';

import '../../../resources/app_text_styles.dart';
import 'text_default.dart';

class TextCustom extends TextDefault {
  TextCustom(
    super.text, {
    super.key,
    super.color,
    super.textAlign,
    super.maxLines,
    super.height,
    this.fontSize = 14,
    this.fontWeight = FontWeight.normal,
  }) : super(
          style: AppTextStyles.regularS.copyWith(
            fontSize: fontSize,
            fontWeight: fontWeight,
          ),
        );

  TextCustom.bold(
    super.text, {
    super.key,
    super.color,
    super.textAlign,
    super.maxLines,
    super.height,
    this.fontSize = 14,
    this.fontWeight = FontWeight.normal,
  }) : super(
          style: AppTextStyles.boldS.copyWith(
            fontSize: fontSize,
            fontWeight: fontWeight,
          ),
        );

  final double fontSize;
  final FontWeight fontWeight;
}
