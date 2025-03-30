import 'package:flutter/material.dart';

class MMTheme {
  MMTheme._(); // this basically makes it so you can instantiate this class
  static const _pinkPrimaryValue = 0xFFFF4081;

  static const MaterialColor pink = MaterialColor(
    _pinkPrimaryValue,
    <int, Color>{
      50: Color(0xFFFFEBEE),
      100: Color(0xFFF8BBD0),
      200: Color(0xFFD48FB1),
      300: Color(0xFFE91E63),
      400: Color(0xFFD81B60),
      500: Color(_pinkPrimaryValue),
      600: Color(0xFFC51162),
      700: Color(0xFFAA0044),
      800: Color(0xFF880E4F),
      900: Color(0xFF560027),
    },
  );

  static headingTextStyle() {
    return const TextStyle(
      color: MMTheme.pink,
      fontWeight: FontWeight.bold,
      fontSize: 18.0,
    );
  }

  static titleTextStyle() {
    return const TextStyle(color: MMTheme.pink, fontWeight: FontWeight.bold);
  }

  static titleTextWhiteStyle() {
    return const TextStyle(color: Colors.white, fontWeight: FontWeight.bold);
  }

  static obituaryTitleTextStyle() {
    return const TextStyle(
        color: MMTheme.pink, fontWeight: FontWeight.bold, fontSize: 16.0);
  }

  static boldTextStyle() {
    return const TextStyle(
        color: MMTheme.pink, fontWeight: FontWeight.bold, fontSize: 14);
  }

  static bodyTextStyle() {
    return const TextStyle(
      color: MMTheme.pink,
      fontSize: 14.0,
    );
  }

  static prefixTextStyle() {
    return const TextStyle(color: MMTheme.pink, fontSize: 14.0);
  }

  static bodyMalayalamTextStyle() {
    return const TextStyle(
        color: MMTheme.pink, fontSize: 14.0, fontFamily: "thiruvachanam");
  }

  static prefixMalayalamTextStyle() {
    return const TextStyle(
        color: MMTheme.pink, fontSize: 18.0, fontFamily: "thiruvachanam");
  }

  static titleMalayalamTextStyle() {
    return const TextStyle(
        color: MMTheme.pink, fontSize: 20.0, fontFamily: "thiruvachanam");
  }

  static titleMalayalamTextWhiteStyle() {
    return const TextStyle(
        color: Colors.white, fontSize: 20.0, fontFamily: "thiruvachanam");
  }

  static italicbodyTextStyle() {
    return const TextStyle(
        color: MMTheme.pink, fontSize: 14.0, fontStyle: FontStyle.italic);
  }

  static boldbodyTextStyle() {
    return const TextStyle(
        color: MMTheme.pink, fontSize: 14.0, fontWeight: FontWeight.bold);
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
        color: MMTheme.pink,
        fontSize: 16.0,
        fontFamily: "thiruvachanam",
        fontStyle: FontStyle.italic);
  }

  static ThemeData kGalleryDarkTheme = ThemeData(
  brightness: Brightness.dark,
  colorSchemeSeed: MMTheme.pink,
  dividerColor: Colors.transparent,
  scaffoldBackgroundColor: Colors.black,
  useMaterial3: true,
  );
  static ThemeData kGalleryLightTheme = ThemeData(
    brightness: Brightness.light,
    dividerColor: Colors.transparent,
    scaffoldBackgroundColor: Colors.white,
    colorScheme: ColorScheme.fromSeed(
      seedColor: MMTheme.pink,
      onTertiary: Colors.orange,
      secondary: MMTheme.pink,
    ),
  );
}
