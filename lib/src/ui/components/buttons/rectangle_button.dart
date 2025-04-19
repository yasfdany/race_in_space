import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../texts/text.dart';

class RectangleButton extends StatefulWidget {
  const RectangleButton({
    super.key,
    this.width,
    this.height,
    this.child,
    this.text,
    this.color,
    this.disabledColor,
    this.padding,
    this.onTap,
    this.disabled = false,
    this.border,
  });

  final double? width;
  final double? height;
  final Widget? child;
  final String? text;
  final Color? color;
  final Color? disabledColor;
  final EdgeInsets? padding;
  final VoidCallback? onTap;
  final bool disabled;
  final Border? border;

  @override
  State<RectangleButton> createState() => _RectangleButtonState();
}

class _RectangleButtonState extends State<RectangleButton> {
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    final defaultColor = widget.color ?? Colors.green;
    final disabledColor = widget.disabledColor ?? Colors.grey;

    return GestureDetector(
      onTap: widget.disabled ? null : widget.onTap,
      onTapDown: (details) async {
        setState(() {
          isPressed = true;
        });
      },
      onTapUp: (details) {
        setState(() {
          isPressed = false;
        });
      },
      onTapCancel: () {
        setState(() {
          isPressed = false;
        });
      },
      child: Animate(
        target: isPressed ? 1 : 0,
        effects: [
          ScaleEffect(
            begin: Offset(1, 1),
            end: Offset(0.9, 0.9),
            duration: 100.ms,
          ),
        ],
        child: Container(
          width: widget.width,
          height: widget.height,
          padding: widget.padding ?? EdgeInsets.all(8.w),
          decoration: BoxDecoration(
            color: widget.disabled ? disabledColor : defaultColor,
            borderRadius: BorderRadius.circular(8.w),
            border: widget.border,
          ),
          alignment: Alignment.center,
          child: widget.child ??
              TextMedium(
                widget.text ?? '',
                color: Colors.white,
              ),
        ),
      ),
    );
  }
}
