import '../../../main.dart';
import '../../controllers/assets_controller.dart';
import '../../controllers/audio_controller.dart';
import '../../controllers/setting_controller.dart';
import '../../controllers/shader_controller.dart';
import '../../utils/helpers/pref_helper.dart';
import 'get_it_ext.dart';

class GetItConfig {
  static Future<void> register() async {
    locator.registerSingleton(PrefHelper());
    locator.registerSingleton(SettingController());
    locator.registerSingleton(AudioController());
    locator.registerSingleton(AssetsController());
    locator.registerSingleton(ShaderController());

    await Future.wait([
      locator.prefHelper.init(),
      locator.assetsController.init(),
      locator.assetsController.init(),
      locator.shaderController.init(),
      locator.audioController.loadSfx(),
    ]);
  }
}
