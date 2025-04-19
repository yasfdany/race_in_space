import 'package:get_it/get_it.dart';

import '../../controllers/assets_controller.dart';

extension GetItExt on GetIt {
  AssetsController get assetsController => get<AssetsController>();
}
