import '../game_scene.dart';
import 'game_state.dart';

class GameController {
  GameController(this.state, this.game);

  GameScene game;
  GameState state;
}
