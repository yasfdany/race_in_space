import '../../../resources/app_text_styles.dart';
import 'text_default.dart';

class TextExtraLarge extends TextDefault {
  TextExtraLarge(
    super.text, {
    super.key,
    super.color,
    super.textAlign,
    super.maxLines,
    super.height,
  }) : super(style: AppTextStyles.regularXL);

  TextExtraLarge.bold(
    super.text, {
    super.key,
    super.color,
    super.textAlign,
    super.maxLines,
    super.height,
  }) : super(style: AppTextStyles.boldXL);
}
