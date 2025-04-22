import '../../../main.dart';
import '../../controllers/assets_controller.dart';
import '../../controllers/shader_controller.dart';

class GetItConfig {
  static Future<void> register() async {
    locator.registerSingleton(AssetsController());
    locator.registerSingleton(ShaderController());
  }
}
