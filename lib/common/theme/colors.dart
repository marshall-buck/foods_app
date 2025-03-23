import 'package:flutter/material.dart';
import 'package:foods_app/common/theme/text_styles.dart';

class AppTheme {
  const AppTheme(this.textTheme);
  final TextTheme textTheme;

  static MaterialScheme lightScheme() {
    return const MaterialScheme(
      brightness: Brightness.light,
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
  }

  ThemeData light() {
    return theme(lightScheme().toColorScheme());
  }

  static MaterialScheme lightMediumContrastScheme() {
    return const MaterialScheme(
      brightness: Brightness.light,
      primary: Color(0xff004c3f),
      surfaceTint: Color(0xff096b5a),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff2e8270),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff2f4841),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff617a72),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff26465b),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff59788f),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff8c0009),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffda342e),
      onErrorContainer: Color(0xffffffff),
      background: Color(0xfff5fbf7),
      onBackground: Color(0xff171d1b),
      surface: Color(0xfff5fbf7),
      onSurface: Color(0xff171d1b),
      surfaceVariant: Color(0xffdbe5e0),
      onSurfaceVariant: Color(0xff3b4542),
      outline: Color(0xff57615e),
      outlineVariant: Color(0xff737d79),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2b322f),
      inverseOnSurface: Color(0xffecf2ee),
      inversePrimary: Color(0xff85d6c1),
      primaryFixed: Color(0xff2e8270),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff036857),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff617a72),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff48615a),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff59788f),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff406075),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffd5dbd8),
      surfaceBright: Color(0xfff5fbf7),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xffeff5f1),
      surfaceContainer: Color(0xffe9efec),
      surfaceContainerHigh: Color(0xffe3eae6),
      surfaceContainerHighest: Color(0xffdee4e0),
    );
  }

  ThemeData lightMediumContrast() {
    return theme(lightMediumContrastScheme().toColorScheme());
  }

  static MaterialScheme lightHighContrastScheme() {
    return const MaterialScheme(
      brightness: Brightness.light,
      primary: Color(0xff002820),
      surfaceTint: Color(0xff096b5a),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff004c3f),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff0e2621),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff2f4841),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff002537),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff26465b),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff4e0002),
      onError: Color(0xffffffff),
      errorContainer: Color(0xff8c0009),
      onErrorContainer: Color(0xffffffff),
      background: Color(0xfff5fbf7),
      onBackground: Color(0xff171d1b),
      surface: Color(0xfff5fbf7),
      onSurface: Color(0xff000000),
      surfaceVariant: Color(0xffdbe5e0),
      onSurfaceVariant: Color(0xff1d2623),
      outline: Color(0xff3b4542),
      outlineVariant: Color(0xff3b4542),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2b322f),
      inverseOnSurface: Color(0xffffffff),
      inversePrimary: Color(0xffaafce6),
      primaryFixed: Color(0xff004c3f),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff00342a),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff2f4841),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff19312b),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff26465b),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff0b3043),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffd5dbd8),
      surfaceBright: Color(0xfff5fbf7),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xffeff5f1),
      surfaceContainer: Color(0xffe9efec),
      surfaceContainerHigh: Color(0xffe3eae6),
      surfaceContainerHighest: Color(0xffdee4e0),
    );
  }

  ThemeData lightHighContrast() {
    return theme(lightHighContrastScheme().toColorScheme());
  }

  static MaterialScheme darkScheme() {
    return const MaterialScheme(
      brightness: Brightness.dark,
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
  }

  ThemeData dark() {
    return theme(darkScheme().toColorScheme());
  }

  static MaterialScheme darkMediumContrastScheme() {
    return const MaterialScheme(
      brightness: Brightness.dark,
      primary: Color(0xff89dac5),
      surfaceTint: Color(0xff85d6c1),
      onPrimary: Color(0xff001a15),
      primaryContainer: Color(0xff4e9f8c),
      onPrimaryContainer: Color(0xff000000),
      secondary: Color(0xffb6d1c7),
      onSecondary: Color(0xff021a15),
      secondaryContainer: Color(0xff7c968e),
      onSecondaryContainer: Color(0xff000000),
      tertiary: Color(0xffaecfe8),
      onTertiary: Color(0xff001826),
      tertiaryContainer: Color(0xff7595ac),
      onTertiaryContainer: Color(0xff000000),
      error: Color(0xffffbab1),
      onError: Color(0xff370001),
      errorContainer: Color(0xffff5449),
      onErrorContainer: Color(0xff000000),
      background: Color(0xff0e1513),
      onBackground: Color(0xffdee4e0),
      surface: Color(0xff0e1513),
      onSurface: Color(0xfff6fcf8),
      surfaceVariant: Color(0xff3f4945),
      onSurfaceVariant: Color(0xffc3cdc8),
      outline: Color(0xff9ba5a1),
      outlineVariant: Color(0xff7b8581),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffdee4e0),
      inverseOnSurface: Color(0xff252b29),
      inversePrimary: Color(0xff005244),
      primaryFixed: Color(0xffa1f2dc),
      onPrimaryFixed: Color(0xff001510),
      primaryFixedDim: Color(0xff85d6c1),
      onPrimaryFixedVariant: Color(0xff003e33),
      secondaryFixed: Color(0xffcde8df),
      onSecondaryFixed: Color(0xff001510),
      secondaryFixedDim: Color(0xffb1ccc3),
      onSecondaryFixedVariant: Color(0xff233b34),
      tertiaryFixed: Color(0xffc7e7ff),
      onTertiaryFixed: Color(0xff00131f),
      tertiaryFixedDim: Color(0xffaacbe3),
      onTertiaryFixedVariant: Color(0xff17394d),
      surfaceDim: Color(0xff0e1513),
      surfaceBright: Color(0xff343b38),
      surfaceContainerLowest: Color(0xff090f0e),
      surfaceContainerLow: Color(0xff171d1b),
      surfaceContainer: Color(0xff1b211f),
      surfaceContainerHigh: Color(0xff252b29),
      surfaceContainerHighest: Color(0xff303634),
    );
  }

  ThemeData darkMediumContrast() {
    return theme(darkMediumContrastScheme().toColorScheme());
  }

  static MaterialScheme darkHighContrastScheme() {
    return const MaterialScheme(
      brightness: Brightness.dark,
      primary: Color(0xffecfff8),
      surfaceTint: Color(0xff85d6c1),
      onPrimary: Color(0xff000000),
      primaryContainer: Color(0xff89dac5),
      onPrimaryContainer: Color(0xff000000),
      secondary: Color(0xffecfff8),
      onSecondary: Color(0xff000000),
      secondaryContainer: Color(0xffb6d1c7),
      onSecondaryContainer: Color(0xff000000),
      tertiary: Color(0xfff8fbff),
      onTertiary: Color(0xff000000),
      tertiaryContainer: Color(0xffaecfe8),
      onTertiaryContainer: Color(0xff000000),
      error: Color(0xfffff9f9),
      onError: Color(0xff000000),
      errorContainer: Color(0xffffbab1),
      onErrorContainer: Color(0xff000000),
      background: Color(0xff0e1513),
      onBackground: Color(0xffdee4e0),
      surface: Color(0xff0e1513),
      onSurface: Color(0xffffffff),
      surfaceVariant: Color(0xff3f4945),
      onSurfaceVariant: Color(0xfff3fdf8),
      outline: Color(0xffc3cdc8),
      outlineVariant: Color(0xffc3cdc8),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffdee4e0),
      inverseOnSurface: Color(0xff000000),
      inversePrimary: Color(0xff003128),
      primaryFixed: Color(0xffa5f7e1),
      onPrimaryFixed: Color(0xff000000),
      primaryFixedDim: Color(0xff89dac5),
      onPrimaryFixedVariant: Color(0xff001a15),
      secondaryFixed: Color(0xffd1ede3),
      onSecondaryFixed: Color(0xff000000),
      secondaryFixedDim: Color(0xffb6d1c7),
      onSecondaryFixedVariant: Color(0xff021a15),
      tertiaryFixed: Color(0xffd0eaff),
      onTertiaryFixed: Color(0xff000000),
      tertiaryFixedDim: Color(0xffaecfe8),
      onTertiaryFixedVariant: Color(0xff001826),
      surfaceDim: Color(0xff0e1513),
      surfaceBright: Color(0xff343b38),
      surfaceContainerLowest: Color(0xff090f0e),
      surfaceContainerLow: Color(0xff171d1b),
      surfaceContainer: Color(0xff1b211f),
      surfaceContainerHigh: Color(0xff252b29),
      surfaceContainerHighest: Color(0xff303634),
    );
  }

  ThemeData darkHighContrast() {
    return theme(darkHighContrastScheme().toColorScheme());
  }

  TextTheme applyToTextTheme(TextTheme baseTextTheme, ColorScheme colorScheme) {
    return baseTextTheme.copyWith(
      displayLarge: baseTextTheme.displayLarge?.copyWith(color: colorScheme.onSurface),
      displayMedium: baseTextTheme.displayMedium?.copyWith(color: colorScheme.onSurface),
      displaySmall: baseTextTheme.displaySmall?.copyWith(color: colorScheme.onSurface),
      headlineLarge: baseTextTheme.headlineLarge?.copyWith(color: colorScheme.onSurface),
      headlineMedium: baseTextTheme.headlineMedium?.copyWith(color: colorScheme.onSurface),
      headlineSmall: baseTextTheme.headlineSmall?.copyWith(color: colorScheme.onSurface),
      titleLarge: baseTextTheme.titleLarge?.copyWith(color: colorScheme.onSurface),
      titleMedium: baseTextTheme.titleMedium?.copyWith(color: colorScheme.onSurface),
      titleSmall: baseTextTheme.titleSmall?.copyWith(color: colorScheme.onSurface),
      bodyLarge: baseTextTheme.bodyLarge?.copyWith(color: colorScheme.onSurface),
      bodyMedium: baseTextTheme.bodyMedium?.copyWith(color: colorScheme.onSurface),
      bodySmall: baseTextTheme.bodySmall?.copyWith(color: colorScheme.onSurface),
      labelLarge: baseTextTheme.labelLarge?.copyWith(color: colorScheme.onSurface),
      labelMedium: baseTextTheme.labelMedium?.copyWith(color: colorScheme.onSurface),
      labelSmall: baseTextTheme.labelSmall?.copyWith(color: colorScheme.onSurface),
    );
  }

  ThemeData theme(ColorScheme colorScheme) => ThemeData(
        useMaterial3: true,
        brightness: colorScheme.brightness,
        colorScheme: colorScheme,
        textTheme: applyToTextTheme(appTextTheme, colorScheme),
        scaffoldBackgroundColor: colorScheme.surface,
        canvasColor: colorScheme.surface,
      );

  List<ExtendedColor> get extendedColors => [];
}

class MaterialScheme {
  const MaterialScheme({
    required this.brightness,
    required this.primary,
    required this.surfaceTint,
    required this.onPrimary,
    required this.primaryContainer,
    required this.onPrimaryContainer,
    required this.secondary,
    required this.onSecondary,
    required this.secondaryContainer,
    required this.onSecondaryContainer,
    required this.tertiary,
    required this.onTertiary,
    required this.tertiaryContainer,
    required this.onTertiaryContainer,
    required this.error,
    required this.onError,
    required this.errorContainer,
    required this.onErrorContainer,
    required this.background,
    required this.onBackground,
    required this.surface,
    required this.onSurface,
    required this.surfaceVariant,
    required this.onSurfaceVariant,
    required this.outline,
    required this.outlineVariant,
    required this.shadow,
    required this.scrim,
    required this.inverseSurface,
    required this.inverseOnSurface,
    required this.inversePrimary,
    required this.primaryFixed,
    required this.onPrimaryFixed,
    required this.primaryFixedDim,
    required this.onPrimaryFixedVariant,
    required this.secondaryFixed,
    required this.onSecondaryFixed,
    required this.secondaryFixedDim,
    required this.onSecondaryFixedVariant,
    required this.tertiaryFixed,
    required this.onTertiaryFixed,
    required this.tertiaryFixedDim,
    required this.onTertiaryFixedVariant,
    required this.surfaceDim,
    required this.surfaceBright,
    required this.surfaceContainerLowest,
    required this.surfaceContainerLow,
    required this.surfaceContainer,
    required this.surfaceContainerHigh,
    required this.surfaceContainerHighest,
  });

  final Brightness brightness;
  final Color primary;
  final Color surfaceTint;
  final Color onPrimary;
  final Color primaryContainer;
  final Color onPrimaryContainer;
  final Color secondary;
  final Color onSecondary;
  final Color secondaryContainer;
  final Color onSecondaryContainer;
  final Color tertiary;
  final Color onTertiary;
  final Color tertiaryContainer;
  final Color onTertiaryContainer;
  final Color error;
  final Color onError;
  final Color errorContainer;
  final Color onErrorContainer;
  final Color background;
  final Color onBackground;
  final Color surface;
  final Color onSurface;
  final Color surfaceVariant;
  final Color onSurfaceVariant;
  final Color outline;
  final Color outlineVariant;
  final Color shadow;
  final Color scrim;
  final Color inverseSurface;
  final Color inverseOnSurface;
  final Color inversePrimary;
  final Color primaryFixed;
  final Color onPrimaryFixed;
  final Color primaryFixedDim;
  final Color onPrimaryFixedVariant;
  final Color secondaryFixed;
  final Color onSecondaryFixed;
  final Color secondaryFixedDim;
  final Color onSecondaryFixedVariant;
  final Color tertiaryFixed;
  final Color onTertiaryFixed;
  final Color tertiaryFixedDim;
  final Color onTertiaryFixedVariant;
  final Color surfaceDim;
  final Color surfaceBright;
  final Color surfaceContainerLowest;
  final Color surfaceContainerLow;
  final Color surfaceContainer;
  final Color surfaceContainerHigh;
  final Color surfaceContainerHighest;
}

extension MaterialSchemeUtils on MaterialScheme {
  ColorScheme toColorScheme() {
    return ColorScheme(
      brightness: brightness,
      primary: primary,
      onPrimary: onPrimary,
      primaryContainer: primaryContainer,
      onPrimaryContainer: onPrimaryContainer,
      primaryFixed: primaryFixed,
      primaryFixedDim: primaryFixedDim,
      onPrimaryFixed: onPrimaryFixed,
      onPrimaryFixedVariant: onPrimaryFixedVariant,
      secondary: secondary,
      onSecondary: onSecondary,
      secondaryContainer: secondaryContainer,
      onSecondaryContainer: onSecondaryContainer,
      secondaryFixed: secondaryFixed,
      secondaryFixedDim: secondaryFixedDim,
      onSecondaryFixed: onSecondaryFixed,
      onSecondaryFixedVariant: onSecondaryFixedVariant,
      tertiary: tertiary,
      onTertiary: onTertiary,
      tertiaryContainer: tertiaryContainer,
      onTertiaryContainer: onTertiaryContainer,
      tertiaryFixed: tertiaryFixed,
      tertiaryFixedDim: tertiaryFixedDim,
      onTertiaryFixed: onTertiaryFixed,
      onTertiaryFixedVariant: onTertiaryFixedVariant,
      error: error,
      onError: onError,
      errorContainer: errorContainer,
      onErrorContainer: onErrorContainer,
      surface: surface,
      onSurface: onSurface,
      surfaceDim: surfaceDim,
      surfaceBright: surfaceBright,
      surfaceContainerLowest: surfaceContainerLowest,
      surfaceContainerLow: surfaceContainerLow,
      surfaceContainer: surfaceContainer,
      surfaceContainerHigh: surfaceContainerHigh,
      surfaceContainerHighest: surfaceContainerHighest,
      onSurfaceVariant: onSurfaceVariant,
      outline: outline,
      outlineVariant: outlineVariant,
      shadow: shadow,
      scrim: scrim,
      inverseSurface: inverseSurface,
      onInverseSurface: inverseOnSurface,
      inversePrimary: inversePrimary,
      surfaceTint: surfaceTint,
    );
  }
}

class ExtendedColor {
  const ExtendedColor({
    required this.seed,
    required this.value,
    required this.light,
    required this.lightHighContrast,
    required this.lightMediumContrast,
    required this.dark,
    required this.darkHighContrast,
    required this.darkMediumContrast,
  });
  final Color seed;
  final Color value;
  final ColorFamily light;
  final ColorFamily lightHighContrast;
  final ColorFamily lightMediumContrast;
  final ColorFamily dark;
  final ColorFamily darkHighContrast;
  final ColorFamily darkMediumContrast;
}

class ColorFamily {
  const ColorFamily({
    required this.color,
    required this.onColor,
    required this.colorContainer,
    required this.onColorContainer,
  });

  final Color color;
  final Color onColor;
  final Color colorContainer;
  final Color onColorContainer;
}
