import '../../../resources/app_text_styles.dart';
import 'text_default.dart';

class TextMedium extends TextDefault {
  TextMedium(
    super.text, {
    super.key,
    super.color,
    super.textAlign,
    super.maxLines,
    super.height,
  }) : super(style: AppTextStyles.regularM);

  TextMedium.bold(
    super.text, {
    super.key,
    super.color,
    super.textAlign,
    super.maxLines,
    super.height,
  }) : super(style: AppTextStyles.boldM);
}
