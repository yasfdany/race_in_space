import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flame/game.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_soloud/flutter_soloud.dart';

import '../../main.dart';
import '../config/di/get_it_ext.dart';
import '../utils/helpers/random_helper.dart';
import 'setting_controller.dart';

class AudioController extends ChangeNotifier {
  late SettingController settingController = locator.settingController;

  late AudioSource solarAppear;
  SoundHandle? solarAppearHandle;

  late AudioSource rocketLaunch;
  SoundHandle? rocketLaunchHandle;

  late AudioSource combust;
  SoundHandle? combustHandle;

  late AudioSource explode;
  SoundHandle? explodeHandle;

  late AudioSource collect;
  SoundHandle? collectHandle;

  late AudioSource tap;
  SoundHandle? tapHandle;

  final bgm = [
    'bgm_1.aac',
    'bgm_2.aac',
    'bgm_3.aac',
    'bgm_4.aac',
  ];
  int currentBgm = 0;

  List<SoundHandle?> get handles => [
        solarAppearHandle,
        rocketLaunchHandle,
        combustHandle,
        explodeHandle,
        collectHandle,
      ];

  void pauseAll() {
    for (final handle in handles) {
      if (handle != null) {
        SoLoud.instance.setPause(handle, true);
      }
    }
  }

  void resumeAll() {
    for (final handle in handles) {
      if (handle != null) {
        SoLoud.instance.setPause(handle, false);
      }
    }
  }

  void playRocketLaunch() async {
    rocketLaunchHandle = await SoLoud.instance.play3d(
      rocketLaunch,
      0,
      0,
      0,
      volume: 0,
    );
    SoLoud.instance.fadeVolume(
      rocketLaunchHandle!,
      0.6 * settingController.sfxVolume,
      0.3.seconds,
    );
  }

  void playCombust() async {
    combustHandle = await SoLoud.instance.play3d(
      combust,
      0,
      0,
      0,
      volume: 0.4 * settingController.sfxVolume,
    );
    SoLoud.instance.fadeVolume(combustHandle!, 0, 1.seconds);
  }

  void playExplode(Vector2 pos) async {
    explodeHandle = await SoLoud.instance.play3d(
      explode,
      pos.x,
      pos.y,
      0,
      volume: 1 * settingController.sfxVolume,
    );
    SoLoud.instance.setRelativePlaySpeed(
      explodeHandle!,
      RandomHelper.rangeDouble(
        min: 0.8,
        max: 1.8,
      ),
    );
  }

  void playCollect(Vector2 pos, double pitch) async {
    collectHandle = await SoLoud.instance.play3d(
      collect,
      pos.x,
      pos.y,
      0,
      volume: 4 * settingController.sfxVolume,
    );
    SoLoud.instance.setRelativePlaySpeed(
      collectHandle!,
      pitch,
    );
  }

  void playSolarAppear(Vector2 pos, double pitch) async {
    solarAppearHandle = await SoLoud.instance.play3d(
      solarAppear,
      pos.x,
      pos.y,
      0,
      volume: 4 * settingController.sfxVolume,
    );
    SoLoud.instance.setRelativePlaySpeed(
      solarAppearHandle!,
      pitch,
    );
  }

  void playTap({double? rate}) async {
    tapHandle = await SoLoud.instance.play(
      tap,
      volume: settingController.sfxVolume,
    );
    SoLoud.instance.setRelativePlaySpeed(
      tapHandle!,
      rate ??
          RandomHelper.rangeDouble(
            min: 0.8,
            max: 1.2,
          ),
    );
  }

  void stopCombust() {
    if (combustHandle == null) return;
    SoLoud.instance.stop(combustHandle!);
    combustHandle = null;
  }

  void init() {
    FlameAudio.bgm.play(
      bgm[currentBgm],
      volume: settingController.volume,
    );
    FlameAudio.bgm.audioPlayer.onPlayerComplete.listen((_) {
      currentBgm = (currentBgm + 1) % bgm.length;
      FlameAudio.bgm.play(
        bgm[currentBgm],
        volume: settingController.volume,
      );
    });
  }

  Future<void> loadSfx() async {
    rocketLaunch = await loadAudio('assets/audio/rocket_launch.mp3');
    combust = await loadAudio('assets/audio/combust.mp3');
    explode = await loadAudio('assets/audio/explode.mp3');
    collect = await loadAudio('assets/audio/collect.mp3');
    solarAppear = await loadAudio('assets/audio/solar_appear.mp3');
    tap = await loadAudio('assets/audio/tap.mp3');
  }

  Future<AudioSource> loadAudio(String path) async {
    final byte = await rootBundle.load(path);
    return await SoLoud.instance.loadMem(
      path.split('/').last,
      byte.buffer.asUint8List(),
      mode: LoadMode.memory, // Default
    );
  }
}
