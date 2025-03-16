import 'package:flutter/material.dart';

class MMTheme {
  MMTheme._(); // this basically makes it so you can instantiate this class
  static const _bluePrimaryValue = 0xFF065fad;

  static const MaterialColor blue = MaterialColor(
    _bluePrimaryValue,
    <int, Color>{
      50: Color(0xFFe0e0e0),
      100: Color(0xFFb3b3b3),
      200: Color(0xFF808080),
      300: Color(0xFF4d4d4d),
      400: Color(0xFF262626),
      500: Color(_bluePrimaryValue),
      600: Color(0xFF000000),
      700: Color(0xFF000000),
      800: Color(0xFF000000),
      900: Color(0xFF000000),
    },
  );

  static headingTextStyle() {
    return const TextStyle(
      color: MMTheme.blue,
      fontWeight: FontWeight.bold,
      fontSize: 18.0,
    );
  }

  static titleTextStyle() {
    return const TextStyle(color: MMTheme.blue, fontWeight: FontWeight.bold);
  }

  static titleTextWhiteStyle() {
    return const TextStyle(color: Colors.white, fontWeight: FontWeight.bold);
  }

  static obituaryTitleTextStyle() {
    return const TextStyle(
        color: MMTheme.blue, fontWeight: FontWeight.bold, fontSize: 16.0);
  }

  static boldTextStyle() {
    return const TextStyle(
        color: MMTheme.blue, fontWeight: FontWeight.bold, fontSize: 14);
  }

  static bodyTextStyle() {
    return const TextStyle(
      color: MMTheme.blue,
      fontSize: 14.0,
    );
  }

  static prefixTextStyle() {
    return const TextStyle(color: MMTheme.blue, fontSize: 14.0);
  }

  static bodyMalayalamTextStyle() {
    return const TextStyle(
        color: MMTheme.blue, fontSize: 14.0, fontFamily: "thiruvachanam");
  }

  static prefixMalayalamTextStyle() {
    return const TextStyle(
        color: MMTheme.blue, fontSize: 18.0, fontFamily: "thiruvachanam");
  }

  static titleMalayalamTextStyle() {
    return const TextStyle(
        color: MMTheme.blue, fontSize: 20.0, fontFamily: "thiruvachanam");
  }

  static titleMalayalamTextWhiteStyle() {
    return const TextStyle(
        color: Colors.white, fontSize: 20.0, fontFamily: "thiruvachanam");
  }

  static italicbodyTextStyle() {
    return const TextStyle(
        color: MMTheme.blue, fontSize: 14.0, fontStyle: FontStyle.italic);
  }

  static boldbodyTextStyle() {
    return const TextStyle(
        color: MMTheme.blue, fontSize: 14.0, fontWeight: FontWeight.bold);
  }

  static linkTextStyle() {
    return const TextStyle(
      color: Colors.black87,
      fontSize: 14.0,
    );
  }

  static bodyGreyTextStyle() {
    return const TextStyle(
      color: Colors.black87,
      fontSize: 12.0,
    );
  }

  static bodyMalayalamGreyTextStyle() {
    return const TextStyle(
        color: Colors.black87, fontSize: 16.0, fontFamily: "thiruvachanam");
  }

  static bodyMalayalamGreyItalicTextStyle() {
    return const TextStyle(
        color: Colors.black87,
        fontSize: 16.0,
        fontFamily: "thiruvachanam",
        fontStyle: FontStyle.italic);
  }

  static italicMalayalamTextStyle() {
    return const TextStyle(
        color: MMTheme.blue,
        fontSize: 16.0,
        fontFamily: "thiruvachanam",
        fontStyle: FontStyle.italic);
  }

  static ThemeData kGalleryDarkTheme = ThemeData(
    brightness: Brightness.dark,
    colorSchemeSeed: MMTheme.blue,
    dividerColor: Colors.transparent,
    useMaterial3: true,
  );
  static ThemeData kGalleryLightTheme = ThemeData(
    brightness: Brightness.light,
    dividerColor: Colors.transparent,
    colorScheme: ColorScheme.fromSeed(
      seedColor: MMTheme.blue,
      onTertiary: Colors.orange,
      secondary: MMTheme.blue,
    ),
  );
}
