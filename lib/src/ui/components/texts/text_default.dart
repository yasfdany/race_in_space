import 'package:flutter/material.dart';

class TextDefault extends StatelessWidget {
  const TextDefault(
    this.text, {
    super.key,
    this.style,
    this.color,
    this.textAlign,
    this.maxLines,
    this.height,
  });

  final String text;
  final TextStyle? style;
  final Color? color;
  final TextAlign? textAlign;
  final int? maxLines;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      overflow: maxLines != null ? TextOverflow.ellipsis : null,
      maxLines: maxLines,
      style: style?.copyWith(
        color: color ?? Colors.white,
        height: height,
      ),
    );
  }
}
