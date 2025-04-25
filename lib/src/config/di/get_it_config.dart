import '../../../main.dart';
import '../../controllers/assets_controller.dart';
import '../../controllers/audio_controller.dart';
import '../../controllers/setting_controller.dart';
import '../../controllers/shader_controller.dart';
import 'get_it_ext.dart';

class GetItConfig {
  static Future<void> register() async {
    locator.registerSingleton(SettingController());
    locator.registerSingleton(AudioController());
    locator.registerSingleton(AssetsController());
    locator.registerSingleton(ShaderController());

    await Future.wait([
      locator.assetsController.init(),
      locator.shaderController.init(),
      locator.audioController.loadSfx(),
    ]);
  }
}
