import 'package:flutter/material.dart';

extension WidgetExt on Widget {
  Widget get ignorePointer => IgnorePointer(
        child: this,
      );
}
