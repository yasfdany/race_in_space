import 'package:flame_audio/flame_audio.dart';

import '../../../../../main.dart';
import '../../../../config/di/get_it_ext.dart';
import '../../levels/controllers/level_state.dart';
import '../game_scene.dart';
import '../ui/lose_dialog.dart';
import '../ui/pause_dialog.dart';
import '../ui/win_dialog.dart';
import 'game_state.dart';

class GameController {
  GameController(this.state, this.game);

  GameScene game;
  GameState state;

  final levelState = locator.get<LevelState>();
  final audioController = locator.audioController;

  void retryLevel() {
    game.overlays.remove(LoseDialog.overlayName);
    startLevel(state.level.level - 1);
  }

  void nextLevel() {
    game.overlays.remove(WinDialog.overlayName);
    startLevel(state.level.level);
  }

  void startLevel(int level) {
    state.level = levelState.levels[level];
    state.attempts = state.level.attempts;
    state.solarCollected = 0;

    game.world = state.level.world;
    game.camera.viewfinder.zoom = state.level.zoom;
    game.overlays.add('dark_overlay');
  }

  void pauseGame() {
    game.overlays.add(PauseDialog.overlayName);
    audioController.pauseAll();
    FlameAudio.bgm.pause();
    game.pauseEngine();
  }
}
