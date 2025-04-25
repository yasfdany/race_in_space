import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';

import 'src/config/route/router_controller.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        FlameAudio.bgm.resume();
      case AppLifecycleState.paused:
        FlameAudio.bgm.pause();
      case AppLifecycleState.inactive:
        FlameAudio.bgm.pause();
      case AppLifecycleState.detached:
        break;
      case AppLifecycleState.hidden:
        break;
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return OKToast(
      backgroundColor: Colors.red,
      position: ToastPosition.center,
      child: MaterialApp.router(
        title: 'Race in Space',
        debugShowCheckedModeBanner: false,
        theme: _buildDefaultTheme(),
        routeInformationParser: router.routeInformationParser,
        routerDelegate: router.routerDelegate,
        routeInformationProvider: router.routeInformationProvider,
        builder: _builder,
      ),
    );
  }

  ThemeData _buildDefaultTheme() {
    return ThemeData(
      pageTransitionsTheme: const PageTransitionsTheme(builders: {
        TargetPlatform.android: OpenUpwardsPageTransitionsBuilder(),
        TargetPlatform.iOS: OpenUpwardsPageTransitionsBuilder(),
      }),
    );
  }

  Widget _builder(context, child) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(
        textScaler: const TextScaler.linear(1),
      ),
      child: child ?? Container(),
    );
  }
}
