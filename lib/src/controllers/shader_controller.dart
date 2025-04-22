import 'dart:ui';

class ShaderController {
  ShaderController() {
    init();
  }
  late final FragmentProgram _gravityBubbleFragment;
  late final FragmentProgram _dryPlanetFragment;
  late final FragmentProgram _gasPlanetFragment;
  late final FragmentProgram _solarFragment;

  FragmentShader get gravityBubbleShader =>
      _gravityBubbleFragment.fragmentShader();
  FragmentShader get dryPlanetShader => _dryPlanetFragment.fragmentShader();
  FragmentShader get gasPlanetShader => _gasPlanetFragment.fragmentShader();
  FragmentShader get solarShader => _solarFragment.fragmentShader();

  void init() async {
    _gravityBubbleFragment = await FragmentProgram.fromAsset(
      'assets/shaders/gravity_bubble.frag',
    );
    _dryPlanetFragment = await FragmentProgram.fromAsset(
      'assets/shaders/dry_planet.frag',
    );
    _gasPlanetFragment = await FragmentProgram.fromAsset(
      'assets/shaders/gas_planet.frag',
    );
    _solarFragment = await FragmentProgram.fromAsset(
      'assets/shaders/solar.frag',
    );
  }
}
