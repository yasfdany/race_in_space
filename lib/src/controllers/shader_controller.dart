import 'dart:ui';

class ShaderController {
  late final FragmentProgram _nebulaeFragment;
  late final FragmentProgram _gravityBubbleFragment;
  late final FragmentProgram _dryPlanetFragment;
  late final FragmentProgram _gasPlanetFragment;
  late final FragmentProgram _solarFragment;

  FragmentShader get nebulaeShader => _nebulaeFragment.fragmentShader();
  FragmentShader get gravityBubbleShader =>
      _gravityBubbleFragment.fragmentShader();
  FragmentShader get dryPlanetShader => _dryPlanetFragment.fragmentShader();
  FragmentShader get gasPlanetShader => _gasPlanetFragment.fragmentShader();
  FragmentShader get solarShader => _solarFragment.fragmentShader();

  Future<void> init() async {
    _nebulaeFragment = await FragmentProgram.fromAsset(
      'assets/shaders/nebulae_gas.frag',
    );
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
