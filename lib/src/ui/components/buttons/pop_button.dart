import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../main.dart';
import '../../../config/di/get_it_ext.dart';

class PopButton extends StatefulWidget {
  const PopButton({
    super.key,
    this.child,
    this.onTap,
    this.disabled = false,
  });

  final Widget? child;
  final VoidCallback? onTap;
  final bool disabled;

  @override
  State<PopButton> createState() => _PopButtonState();
}

class _PopButtonState extends State<PopButton> {
  late final audioController = locator.audioController;
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.disabled ? null : widget.onTap,
      onTapDown: (details) async {
        audioController.playTap(
          rate: widget.disabled ? 0.5 : null,
        );
        setState(() {
          isPressed = true;
        });
      },
      onTapCancel: () {
        setState(() {
          isPressed = false;
        });
      },
      child: Stack(
        children: [
          Animate(
            onComplete: (controller) {
              setState(() {
                isPressed = false;
              });
            },
            target: isPressed ? 1 : 0,
            effects: [
              if (widget.disabled)
                ShakeEffect(
                  offset: Offset(4, 0),
                  rotation: 0,
                  duration: 100.ms,
                )
              else
                ScaleEffect(
                  end: Offset(0.9, 0.9),
                  duration: 50.ms,
                ),
            ],
            child: widget.child ?? Container(),
          ),
        ],
      ),
    );
  }
}
