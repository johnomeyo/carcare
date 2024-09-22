import "package:flutter/material.dart";

class MaterialTheme {
  final TextTheme textTheme;

  const MaterialTheme(this.textTheme);

  static ColorScheme lightScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff11212d),
      surfaceTint: Color(0x0011212d),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xfff4a5c6a),
      onPrimaryContainer: Color(0xff06141b),
      secondary: Color(0xff11212d),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xffb7f4d6),
      onSecondaryContainer: Color(0xff11212D),
      tertiary: Color(0xff1c667d),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xffb2e8ff),
      onTertiaryContainer: Color(0xff004d61),
      error: Color(0xffba1a1a),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffffdad6),
      onErrorContainer: Color(0xff410002),
      surface: Color(0xfff3fcf4),
      onSurface: Color(0xff151d19),
      onSurfaceVariant: Color(0xff3b4a42),
      outline: Color(0xff6b7b72),
      outlineVariant: Color(0xffbacac0),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2a322e),
      inversePrimary: Color(0xff4a5c6a),
      primaryFixed: Color(0xff4a5c6a),
      onPrimaryFixed: Color(0xff002115),
      primaryFixedDim: Color(0xff4a5c6a),
      onPrimaryFixedVariant: Color(0xff06141b),
      secondaryFixed: Color(0xffb3f0d2),
      onSecondaryFixed: Color(0xff002115),
      secondaryFixedDim: Color(0xff9ba8ab),
      onSecondaryFixedVariant: Color(0xff06141b),
      tertiaryFixed: Color(0xffb9eaff),
      onTertiaryFixed: Color(0xff001f29),
      tertiaryFixedDim: Color(0xff8fd0ea),
      onTertiaryFixedVariant: Color(0xff004d62),
      surfaceDim: Color(0xffd3dcd5),
      surfaceBright: Color(0xfff3fcf4),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xffedf6ef),
      surfaceContainer: Color(0xffe7f0e9),
      surfaceContainerHigh: Color(0xffe1eae3),
      surfaceContainerHighest: Color(0xffdce5de),
    );
  }

  ThemeData light() {
    return theme(lightScheme());
  }

  static ColorScheme lightMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff06141b),
      surfaceTint: Color(0x0011212d),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff008560),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff0c4c37),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff11212d),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff00495d),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff397d95),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff8c0009),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffda342e),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfff3fcf4),
      onSurface: Color(0xff151d19),
      onSurfaceVariant: Color(0xff37463e),
      outline: Color(0xff53635a),
      outlineVariant: Color(0xff6f7e75),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2a322e),
      inversePrimary: Color(0xff4a5c6a),
      primaryFixed: Color(0xff008560),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff00694b),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff11212d),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff2c664f),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff397d95),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff18647b),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffd3dcd5),
      surfaceBright: Color(0xfff3fcf4),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xffedf6ef),
      surfaceContainer: Color(0xffe7f0e9),
      surfaceContainerHigh: Color(0xffe1eae3),
      surfaceContainerHighest: Color(0xffdce5de),
    );
  }

  ThemeData lightMediumContrast() {
    return theme(lightMediumContrastScheme());
  }

  static ColorScheme lightHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff00281b),
      surfaceTint: Color(0x0011212d),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff06141b),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff00281b),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff0c4c37),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff002631),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff00495d),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff4e0002),
      onError: Color(0xffffffff),
      errorContainer: Color(0xff8c0009),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfff3fcf4),
      onSurface: Color(0xff000000),
      onSurfaceVariant: Color(0xff192720),
      outline: Color(0xff37463e),
      outlineVariant: Color(0xff37463e),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2a322e),
      inversePrimary: Color(0xffa0ffd5),
      primaryFixed: Color(0xff06141b),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff003423),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff0c4c37),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff003423),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff00495d),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff00313f),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffd3dcd5),
      surfaceBright: Color(0xfff3fcf4),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xffedf6ef),
      surfaceContainer: Color(0xffe7f0e9),
      surfaceContainerHigh: Color(0xffe1eae3),
      surfaceContainerHighest: Color(0xffdce5de),
    );
  }

  ThemeData lightHighContrast() {
    return theme(lightHighContrastScheme());
  }

  static ColorScheme darkScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffffffff),
      surfaceTint: Color(0xff4a5c6a),
      onPrimary: Color(0xff003827),
      primaryContainer: Color(0xff35efb3),
      onPrimaryContainer: Color(0xff004933),
      secondary: Color(0xff9ba8ab),
      onSecondary: Color(0xff003827),
      secondaryContainer: Color(0xff054833),
      onSecondaryContainer: Color(0xffa4e1c3),
      tertiary: Color(0xffffffff),
      onTertiary: Color(0xff003544),
      tertiaryContainer: Color(0xff9ddef8),
      onTertiaryContainer: Color(0xff004558),
      error: Color(0xffffb4ab),
      onError: Color(0xff690005),
      errorContainer: Color(0xff93000a),
      onErrorContainer: Color(0xffffdad6),
      surface: Color(0xff0d1511),
      onSurface: Color(0xffdce5de),
      onSurfaceVariant: Color(0xffbacac0),
      outline: Color(0xff84948b),
      outlineVariant: Color(0xff3b4a42),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffdce5de),
      inversePrimary: Color(0x0011212d),
      primaryFixed: Color(0xff4a5c6a),
      onPrimaryFixed: Color(0xff002115),
      primaryFixedDim: Color(0xff4a5c6a),
      onPrimaryFixedVariant: Color(0xff06141b),
      secondaryFixed: Color(0xffb3f0d2),
      onSecondaryFixed: Color(0xff002115),
      secondaryFixedDim: Color(0xff9ba8ab),
      onSecondaryFixedVariant: Color(0xff06141b),
      tertiaryFixed: Color(0xffb9eaff),
      onTertiaryFixed: Color(0xff001f29),
      tertiaryFixedDim: Color(0xff8fd0ea),
      onTertiaryFixedVariant: Color(0xff004d62),
      surfaceDim: Color(0xff0d1511),
      surfaceBright: Color(0xff333b36),
      surfaceContainerLowest: Color(0xff08100c),
      surfaceContainerLow: Color(0xff151d19),
      surfaceContainer: Color(0xff19211d),
      surfaceContainerHigh: Color(0xff242c27),
      surfaceContainerHighest: Color(0xff2e3732),
    );
  }

  ThemeData dark() {
    return theme(darkScheme());
  }

  static ColorScheme darkMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffffffff),
      surfaceTint: Color(0xff4a5c6a),
      onPrimary: Color(0xff003827),
      primaryContainer: Color(0xff35efb3),
      onPrimaryContainer: Color(0xff002518),
      secondary: Color(0xff9bd7bb),
      onSecondary: Color(0xff001b11),
      secondaryContainer: Color(0xff629c82),
      onSecondaryContainer: Color(0xff000000),
      tertiary: Color(0xffffffff),
      onTertiary: Color(0xff003544),
      tertiaryContainer: Color(0xff9ddef8),
      onTertiaryContainer: Color(0xff00232e),
      error: Color(0xffffbab1),
      onError: Color(0xff370001),
      errorContainer: Color(0xffff5449),
      onErrorContainer: Color(0xff000000),
      surface: Color(0xff0d1511),
      onSurface: Color(0xfff4fdf6),
      onSurfaceVariant: Color(0xffbecfc4),
      outline: Color(0xff96a79d),
      outlineVariant: Color(0xff77877e),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffdce5de),
      inversePrimary: Color(0xff00533a),
      primaryFixed: Color(0xff4a5c6a),
      onPrimaryFixed: Color(0xff00150c),
      primaryFixedDim: Color(0xff4a5c6a),
      onPrimaryFixedVariant: Color(0xff003f2b),
      secondaryFixed: Color(0xffb3f0d2),
      onSecondaryFixed: Color(0xff00150c),
      secondaryFixedDim: Color(0xff9ba8ab),
      onSecondaryFixedVariant: Color(0xff003f2b),
      tertiaryFixed: Color(0xffb9eaff),
      onTertiaryFixed: Color(0xff00141b),
      tertiaryFixedDim: Color(0xff8fd0ea),
      onTertiaryFixedVariant: Color(0xff003b4c),
      surfaceDim: Color(0xff0d1511),
      surfaceBright: Color(0xff333b36),
      surfaceContainerLowest: Color(0xff08100c),
      surfaceContainerLow: Color(0xff151d19),
      surfaceContainer: Color(0xff19211d),
      surfaceContainerHigh: Color(0xff242c27),
      surfaceContainerHighest: Color(0xff2e3732),
    );
  }

  ThemeData darkMediumContrast() {
    return theme(darkMediumContrastScheme());
  }

  static ColorScheme darkHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffffffff),
      surfaceTint: Color(0xff4a5c6a),
      onPrimary: Color(0xff000000),
      primaryContainer: Color(0xff35efb3),
      onPrimaryContainer: Color(0xff000000),
      secondary: Color(0xffedfff4),
      onSecondary: Color(0xff000000),
      secondaryContainer: Color(0xff9bd7bb),
      onSecondaryContainer: Color(0xff000000),
      tertiary: Color(0xffffffff),
      onTertiary: Color(0xff000000),
      tertiaryContainer: Color(0xff9ddef8),
      onTertiaryContainer: Color(0xff000000),
      error: Color(0xfffff9f9),
      onError: Color(0xff000000),
      errorContainer: Color(0xffffbab1),
      onErrorContainer: Color(0xff000000),
      surface: Color(0xff0d1511),
      onSurface: Color(0xffffffff),
      onSurfaceVariant: Color(0xffeefff4),
      outline: Color(0xffbecfc4),
      outlineVariant: Color(0xffbecfc4),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffdce5de),
      inversePrimary: Color(0xff003121),
      primaryFixed: Color(0xff77ffc9),
      onPrimaryFixed: Color(0xff000000),
      primaryFixedDim: Color(0xff20e5aa),
      onPrimaryFixedVariant: Color(0xff001b11),
      secondaryFixed: Color(0xffb7f4d6),
      onSecondaryFixed: Color(0xff000000),
      secondaryFixedDim: Color(0xff9bd7bb),
      onSecondaryFixedVariant: Color(0xff001b11),
      tertiaryFixed: Color(0xffc5edff),
      onTertiaryFixed: Color(0xff000000),
      tertiaryFixedDim: Color(0xff93d4ee),
      onTertiaryFixedVariant: Color(0xff001922),
      surfaceDim: Color(0xff0d1511),
      surfaceBright: Color(0xff333b36),
      surfaceContainerLowest: Color(0xff08100c),
      surfaceContainerLow: Color(0xff151d19),
      surfaceContainer: Color(0xff19211d),
      surfaceContainerHigh: Color(0xff242c27),
      surfaceContainerHighest: Color(0xff2e3732),
    );
  }

  ThemeData darkHighContrast() {
    return theme(darkHighContrastScheme());
  }

  ThemeData theme(ColorScheme colorScheme) => ThemeData(
        useMaterial3: true,
        brightness: colorScheme.brightness,
        colorScheme: colorScheme,
        textTheme: textTheme.apply(
          bodyColor: colorScheme.onSurface,
          displayColor: colorScheme.onSurface,
        ),
        scaffoldBackgroundColor: colorScheme.surface,
        canvasColor: colorScheme.surface,
      );

  /// Custom Color 1
  static const customColor1 = ExtendedColor(
    seed: Color(0xff4db42d),
    value: Color(0xff4db42d),
    light: ColorFamily(
      color: Color(0xff1c6d00),
      onColor: Color(0xffffffff),
      colorContainer: Color(0xff59c139),
      onColorContainer: Color(0xff052600),
    ),
    lightMediumContrast: ColorFamily(
      color: Color(0xff1c6d00),
      onColor: Color(0xffffffff),
      colorContainer: Color(0xff59c139),
      onColorContainer: Color(0xff052600),
    ),
    lightHighContrast: ColorFamily(
      color: Color(0xff1c6d00),
      onColor: Color(0xffffffff),
      colorContainer: Color(0xff59c139),
      onColorContainer: Color(0xff052600),
    ),
    dark: ColorFamily(
      color: Color(0xff75de53),
      onColor: Color(0xff0a3900),
      colorContainer: Color(0xff44ab24),
      onColorContainer: Color(0xff000000),
    ),
    darkMediumContrast: ColorFamily(
      color: Color(0xff75de53),
      onColor: Color(0xff0a3900),
      colorContainer: Color(0xff44ab24),
      onColorContainer: Color(0xff000000),
    ),
    darkHighContrast: ColorFamily(
      color: Color(0xff75de53),
      onColor: Color(0xff0a3900),
      colorContainer: Color(0xff44ab24),
      onColorContainer: Color(0xff000000),
    ),
  );

  List<ExtendedColor> get extendedColors => [
        customColor1,
      ];
}

class ExtendedColor {
  final Color seed, value;
  final ColorFamily light;
  final ColorFamily lightHighContrast;
  final ColorFamily lightMediumContrast;
  final ColorFamily dark;
  final ColorFamily darkHighContrast;
  final ColorFamily darkMediumContrast;

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
