import 'package:get_it/get_it.dart';

import '../../controllers/assets_controller.dart';
import '../../controllers/audio_controller.dart';
import '../../controllers/setting_controller.dart';
import '../../controllers/shader_controller.dart';

extension GetItExt on GetIt {
  SettingController get settingController => get<SettingController>();
  AudioController get audioController => get<AudioController>();
  AssetsController get assetsController => get<AssetsController>();
  ShaderController get shaderController => get<ShaderController>();
}
