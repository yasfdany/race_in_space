import 'dart:math';

class RandomHelper {
  static final random = Random();

  static bool chance(double chance) {
    return random.nextDouble() < chance;
  }

  static double rangeDouble({double min = 0, double max = 1}) {
    return random.nextDouble() * (max - min) + min;
  }

  static int rangeInt({int min = 0, int max = 1}) {
    return random.nextInt(max - min) + min;
  }

  static T choose<T>(List<T> list) {
    return list[random.nextInt(list.length)];
  }

  static bool randomBool() {
    return random.nextBool();
  }
}
