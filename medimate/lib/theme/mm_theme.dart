import 'package:flutter/material.dart';

class MMTheme {
  MMTheme._(); // this basically makes it so you can instantiate this class
  static const _bluePrimaryValue = 0xFF065fad;

  static const MaterialColor blue = const MaterialColor(
    _bluePrimaryValue,
    const <int, Color>{
      50:  const Color(0xFFe0e0e0),
      100: const Color(0xFFb3b3b3),
      200: const Color(0xFF808080),
      300: const Color(0xFF4d4d4d),
      400: const Color(0xFF262626),
      500: const Color(_bluePrimaryValue),
      600: const Color(0xFF000000),
      700: const Color(0xFF000000),
      800: const Color(0xFF000000),
      900: const Color(0xFF000000),
    },
  );

  static headingTextStyle() {
    return new TextStyle(color: MMTheme.blue, fontWeight: FontWeight.bold, fontSize: 18.0,);
  }

  static titleTextStyle() {
    return new TextStyle(color: MMTheme.blue, fontWeight: FontWeight.bold);
  }

  static titleTextWhiteStyle() {
    return new TextStyle(color: Colors.white, fontWeight: FontWeight.bold);
  }

  static obituaryTitleTextStyle() {
    return new TextStyle(color: MMTheme.blue, fontWeight: FontWeight.bold, fontSize: 16.0);
  }

  static boldTextStyle() {
    return new TextStyle(color: MMTheme.blue, fontWeight: FontWeight.bold, fontSize: 14);
  }

  static bodyTextStyle() {
    return new TextStyle(color: MMTheme.blue, fontSize: 14.0,);
  }

  static prefixTextStyle() {
    return new TextStyle(color: MMTheme.blue, fontSize: 14.0);
  }

  static bodyMalayalamTextStyle() {
    return new TextStyle(color: MMTheme.blue, fontSize: 14.0, fontFamily: "thiruvachanam");
  }

  static prefixMalayalamTextStyle() {
    return new TextStyle(color: MMTheme.blue, fontSize: 18.0, fontFamily: "thiruvachanam");
  }

  static titleMalayalamTextStyle() {
    return new TextStyle(color: MMTheme.blue, fontSize: 20.0, fontFamily: "thiruvachanam");
  }

  static titleMalayalamTextWhiteStyle() {
    return new TextStyle(color: Colors.white, fontSize: 20.0, fontFamily: "thiruvachanam");
  }

  static italicbodyTextStyle() {
    return new TextStyle(color: MMTheme.blue, fontSize: 14.0, fontStyle: FontStyle.italic);
  }

  static boldbodyTextStyle() {
    return new TextStyle(color: MMTheme.blue, fontSize: 14.0, fontWeight: FontWeight.bold);
  }

  static linkTextStyle() {
    return new TextStyle(color: Colors.black87, fontSize: 14.0,);
  }

  static bodyGreyTextStyle() {
    return new TextStyle(color: Colors.black87, fontSize: 12.0,);
  }

  static bodyMalayalamGreyTextStyle() {
    return new TextStyle(color: Colors.black87, fontSize: 16.0, fontFamily: "thiruvachanam");
  }

  static bodyMalayalamGreyItalicTextStyle() {
    return new TextStyle(color: Colors.black87, fontSize: 16.0, fontFamily: "thiruvachanam", fontStyle: FontStyle.italic);
  }

  static italicMalayalamTextStyle() {
    return new TextStyle(color: MMTheme.blue, fontSize: 16.0, fontFamily: "thiruvachanam", fontStyle: FontStyle.italic);
  }
}