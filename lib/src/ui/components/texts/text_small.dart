import '../../../resources/app_text_styles.dart';
import 'text_default.dart';

class TextSmall extends TextDefault {
  TextSmall(
    super.text, {
    super.key,
    super.color,
    super.textAlign,
    super.maxLines,
    super.height,
  }) : super(style: AppTextStyles.regularS);

  TextSmall.bold(
    super.text, {
    super.key,
    super.color,
    super.textAlign,
    super.maxLines,
    super.height,
  }) : super(style: AppTextStyles.boldS);
}
