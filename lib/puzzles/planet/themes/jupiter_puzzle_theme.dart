import 'package:flutter/material.dart';
import 'package:planets/resource/app_assets.dart';

import 'planet_puzzle_theme.dart';

class JupiterPuzzleTheme extends PlanetPuzzleTheme {
  const JupiterPuzzleTheme();

  @override
  String get backgroundAsset => '';

  @override
  Color get primary => Colors.blue;

  @override
  Color get onPrimary => Colors.white;

  @override
  Color get surface => Colors.grey;

  @override
  Color get onSurface => Colors.amber;

  @override
  String get assetForTile => AppAssets.jupiterAnimation;
}
