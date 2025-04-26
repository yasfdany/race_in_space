import 'package:flame/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../main.dart';
import '../../../config/di/get_it_ext.dart';
import '../texts/text.dart';

class RectangleButton extends StatefulWidget {
  const RectangleButton({
    super.key,
    this.width,
    this.height = 36,
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
  final double height;
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
  late final audioController = locator.audioController;
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    final defaultColor = widget.color ?? Colors.green;
    final disabledColor = widget.disabledColor ?? Colors.grey;

    return GestureDetector(
      onTap: widget.disabled ? null : widget.onTap,
      onTapDown: (details) async {
        audioController.playTap();
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
      child: Stack(
        children: [
          Container(
            width: widget.width,
            height: widget.height,
            margin: EdgeInsets.only(top: 6),
            decoration: BoxDecoration(
              color: defaultColor.darken(0.3),
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          Animate(
            target: isPressed ? 1 : 0,
            effects: [
              MoveEffect(
                begin: Offset(0, 0),
                end: Offset(0, 6),
                duration: 50.ms,
              ),
            ],
            child: Container(
              width: widget.width,
              height: widget.height,
              padding: widget.padding ?? EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: widget.disabled ? disabledColor : defaultColor,
                borderRadius: BorderRadius.circular(4),
                border: widget.border ??
                    Border.symmetric(
                      horizontal: BorderSide(
                        color: Colors.white.withValues(
                          alpha: 0.2,
                        ),
                      ),
                    ),
              ),
              alignment: Alignment.center,
              child: widget.child ??
                  TextMedium(
                    widget.text ?? '',
                    color: Colors.white,
                    textAlign: TextAlign.center,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
