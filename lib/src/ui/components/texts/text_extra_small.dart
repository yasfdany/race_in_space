import '../../../resources/app_text_styles.dart';
import 'text_default.dart';

class TextExtraSmall extends TextDefault {
  TextExtraSmall(
    super.text, {
    super.key,
    super.color,
    super.textAlign,
    super.maxLines,
    super.height,
  }) : super(style: AppTextStyles.regularXS);

  TextExtraSmall.bold(
    super.text, {
    super.key,
    super.color,
    super.textAlign,
    super.maxLines,
    super.height,
  }) : super(style: AppTextStyles.boldXS);
}
