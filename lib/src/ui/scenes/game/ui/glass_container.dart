import 'dart:ui';

import 'package:flutter/widgets.dart';

class GlassContainer extends StatelessWidget {
  const GlassContainer({
    super.key,
    this.width,
    this.height,
    required this.child,
    required this.color,
    this.padding,
  });

  final double? width;
  final double? height;
  final Widget child;
  final Color color;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 4,
          sigmaY: 4,
        ),
        child: Container(
          width: width,
          height: height,
          padding: padding ?? EdgeInsets.all(24),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: color.withValues(alpha: 0.2),
            border: Border.all(
              color: color,
              width: 2,
            ),
          ),
          child: child,
        ),
      ),
    );
  }
}
