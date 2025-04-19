import '../../../resources/app_text_styles.dart';
import 'text_default.dart';

class TextLarge extends TextDefault {
  TextLarge(
    super.text, {
    super.key,
    super.color,
    super.textAlign,
    super.maxLines,
    super.height,
  }) : super(style: AppTextStyles.regularL);

  TextLarge.bold(
    super.text, {
    super.key,
    super.color,
    super.textAlign,
    super.maxLines,
    super.height,
  }) : super(style: AppTextStyles.boldL);
}
