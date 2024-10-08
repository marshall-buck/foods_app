import 'dart:ui';

import 'package:foods_app/common/common.dart';

const lightColors = FoodsAppThemeExtension(
  //brightness: Brightness.light,
  primary: Color(0xff096b5a),
  surfaceTint: Color(0xff096b5a),
  onPrimary: Color(0xffffffff),
  primaryContainer: Color(0xffa1f2dc),
  onPrimaryContainer: Color(0xff00201a),
  secondary: Color(0xff4b635c),
  onSecondary: Color(0xffffffff),
  secondaryContainer: Color(0xffcde8df),
  onSecondaryContainer: Color(0xff06201a),
  tertiary: Color(0xff426277),
  onTertiary: Color(0xffffffff),
  tertiaryContainer: Color(0xffc7e7ff),
  onTertiaryContainer: Color(0xff001e2e),
  error: Color(0xffba1a1a),
  onError: Color(0xffffffff),
  errorContainer: Color(0xffffdad6),
  onErrorContainer: Color(0xff410002),
  background: Color(0xfff5fbf7),

  onBackground: Color(0xff171d1b),
  surface: Color(0xfff5fbf7),

  onSurface: Color(0xff171d1b),
  surfaceVariant: Color(0xffdbe5e0),
  onSurfaceVariant: Color(0xff3f4945),
  outline: Color(0xff6f7975),
  outlineVariant: Color(0xffbfc9c4),
  shadow: Color(0xff000000),
  scrim: Color(0xff000000),
  inverseSurface: Color(0xff2b322f),
  inverseOnSurface: Color(0xffecf2ee),
  inversePrimary: Color(0xff85d6c1),
  primaryFixed: Color(0xffa1f2dc),
  onPrimaryFixed: Color(0xff00201a),
  primaryFixedDim: Color(0xff85d6c1),
  onPrimaryFixedVariant: Color(0xff005143),
  secondaryFixed: Color(0xffcde8df),
  onSecondaryFixed: Color(0xff06201a),
  secondaryFixedDim: Color(0xffb1ccc3),
  onSecondaryFixedVariant: Color(0xff334b45),
  tertiaryFixed: Color(0xffc7e7ff),
  onTertiaryFixed: Color(0xff001e2e),
  tertiaryFixedDim: Color(0xffaacbe3),
  onTertiaryFixedVariant: Color(0xff2a4a5f),
  surfaceDim: Color(0xffd5dbd8),
  surfaceBright: Color(0xfff5fbf7),
  surfaceContainerLowest: Color(0xffffffff),
  surfaceContainerLow: Color(0xffeff5f1),
  surfaceContainer: Color(0xffe9efec),
  surfaceContainerHigh: Color(0xffe3eae6),
  surfaceContainerHighest: Color(0xffdee4e0),
);

const darkColors = FoodsAppThemeExtension(
  //brightness: Brightness.dark,
  primary: Color(0xff85d6c1),
  surfaceTint: Color(0xff85d6c1),
  onPrimary: Color(0xff00382e),
  primaryContainer: Color(0xff005143),
  onPrimaryContainer: Color(0xffa1f2dc),
  secondary: Color(0xffb1ccc3),
  onSecondary: Color(0xff1d352f),
  secondaryContainer: Color(0xff334b45),
  onSecondaryContainer: Color(0xffcde8df),
  tertiary: Color(0xffaacbe3),
  onTertiary: Color(0xff103447),
  tertiaryContainer: Color(0xff2a4a5f),
  onTertiaryContainer: Color(0xffc7e7ff),
  error: Color(0xffffb4ab),
  onError: Color(0xff690005),
  errorContainer: Color(0xff93000a),
  onErrorContainer: Color(0xffffdad6),
  background: Color(0xff0e1513),
  onBackground: Color(0xffdee4e0),
  surface: Color(0xff0e1513),
  onSurface: Color(0xffdee4e0),
  surfaceVariant: Color(0xff3f4945),
  onSurfaceVariant: Color(0xffbfc9c4),
  outline: Color(0xff89938f),
  outlineVariant: Color(0xff3f4945),
  shadow: Color(0xff000000),
  scrim: Color(0xff000000),
  inverseSurface: Color(0xffdee4e0),
  inverseOnSurface: Color(0xff2b322f),
  inversePrimary: Color(0xff096b5a),
  primaryFixed: Color(0xffa1f2dc),
  onPrimaryFixed: Color(0xff00201a),
  primaryFixedDim: Color(0xff85d6c1),
  onPrimaryFixedVariant: Color(0xff005143),
  secondaryFixed: Color(0xffcde8df),
  onSecondaryFixed: Color(0xff06201a),
  secondaryFixedDim: Color(0xffb1ccc3),
  onSecondaryFixedVariant: Color(0xff334b45),
  tertiaryFixed: Color(0xffc7e7ff),
  onTertiaryFixed: Color(0xff001e2e),
  tertiaryFixedDim: Color(0xffaacbe3),
  onTertiaryFixedVariant: Color(0xff2a4a5f),
  surfaceDim: Color(0xff0e1513),
  surfaceBright: Color(0xff343b38),
  surfaceContainerLowest: Color(0xff090f0e),
  surfaceContainerLow: Color(0xff171d1b),
  surfaceContainer: Color(0xff1b211f),
  surfaceContainerHigh: Color(0xff252b29),
  surfaceContainerHighest: Color(0xff303634),
);
