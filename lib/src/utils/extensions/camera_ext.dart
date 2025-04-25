import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame_noise/flame_noise.dart';

extension CameraExt on CameraComponent {
  void shakeCamera({double duration = 0.5}) {
    viewfinder.add(
      MoveEffect.by(
        Vector2(5, 5),
        NoiseEffectController(
          duration: duration,
          noise: PerlinNoise(
            seed: DateTime.now().millisecondsSinceEpoch,
            frequency: 50,
          ),
        ),
      ),
    );
  }
}
