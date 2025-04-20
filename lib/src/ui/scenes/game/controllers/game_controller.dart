import '../../../../../main.dart';
import '../../levels/controllers/level_state.dart';
import '../game_scene.dart';
import '../ui/win_dialog.dart';
import 'game_state.dart';

class GameController {
  GameController(this.state, this.game);

  GameScene game;
  GameState state;

  final levelState = locator.get<LevelState>();

  void nextLevel() {
    game.overlays.remove(WinDialog.overlayName);
    state.level = levelState.levels[state.level.level];
    state.attempts = state.level.attempts;
    state.solarCollected = 0;

    game.world = state.level.world;
    game.camera.viewfinder.zoom = state.level.zoom;
  }
}
