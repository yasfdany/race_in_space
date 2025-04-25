import 'package:flame/flame.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_soloud/flutter_soloud.dart';
import 'package:get_it/get_it.dart';

import 'app.dart';

final locator = GetIt.instance;

T registerOnce<T extends Object>(T controller) {
  if (locator.isRegistered<T>()) {
    return locator.get<T>();
  }
  return locator.registerSingleton(controller);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Flame.device.fullScreen();
  Flame.device.setPortraitUpOnly();
  FlameAudio.audioCache.loadAll([
    'bgm_1.aac',
    'bgm_2.aac',
    'bgm_3.aac',
    'bgm_4.aac',
  ]);

  await SoLoud.instance.init(
    sampleRate: 44100,
    bufferSize: 2048,
    channels: Channels.stereo,
  );

  runApp(const App());
}
