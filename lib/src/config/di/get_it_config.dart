import '../../../main.dart';
import '../../controllers/assets_controller.dart';
import '../../controllers/audio_controller.dart';
import '../../controllers/setting_controller.dart';
import '../../controllers/shader_controller.dart';

class GetItConfig {
  static Future<void> register() async {
    locator.registerSingleton(SettingController());
    locator.registerSingleton(AudioController());
    locator.registerSingleton(AssetsController());
    locator.registerSingleton(ShaderController());
  }
}
