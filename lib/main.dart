import 'package:flame/flame.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';

import 'app.dart';
import 'src/config/di/get_it_config.dart';

final locator = GetIt.instance;

T registerOnce<T extends Object>(T controller) {
  if (locator.isRegistered<T>()) {
    return locator.get<T>();
  }
  return locator.registerSingleton(controller);
}

void main() async {
  await ScreenUtil.ensureScreenSize();
  Flame.device.fullScreen();
  Flame.device.setPortraitUpOnly();

  GetItConfig.register();

  runApp(const App());
}
