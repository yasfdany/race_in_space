import '../../../main.dart';
import '../../controllers/assets_controller.dart';

class GetItConfig {
  static Future<void> register() async {
    locator.registerSingleton(AssetsController());
  }
}
