import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oktoast/oktoast.dart';

import 'src/config/route/router_controller.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(430, 932),
      child: OKToast(
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
