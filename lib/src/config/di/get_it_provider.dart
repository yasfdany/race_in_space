import 'package:flutter/material.dart';

import '../../../main.dart';

class GetItProvider<T extends ChangeNotifier> extends StatefulWidget {
  const GetItProvider({
    super.key,
    required this.child,
    required this.controller,
  });

  final Widget child;
  final T controller;

  @override
  State<GetItProvider> createState() => _GetItProviderState<T>();
}

class _GetItProviderState<T extends ChangeNotifier>
    extends State<GetItProvider> {
  @override
  void initState() {
    super.initState();
    _registerController();
  }

  @override
  void dispose() {
    _disposeController();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.child;

  void _registerController() {
    registerOnce(widget.controller);
  }

  void _disposeController() {
    if (locator.isRegistered<T>()) {
      locator.unregister<T>(disposingFunction: (i) => i.dispose());
    }
  }
}
