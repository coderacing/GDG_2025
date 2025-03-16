import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:medimate/src/utils/const.dart';

class AppSettingsProvider extends ChangeNotifier {
  static final AppSettingsProvider _instance = AppSettingsProvider._internal();

  factory AppSettingsProvider() => _instance; // Public factory constructor

  AppSettingsProvider._internal(); // Private named constructor

  final GetStorage storage = GetStorage();

  bool isNightTheme() => storage.read(key_night_mode) ?? false;

  void setNightTheme(bool value) {
    storage.write(key_night_mode, value);
    notifyListeners();
  }

  bool toggleTheme() {
    bool value = !isNightTheme();
    storage.write(key_night_mode, value);
    notifyListeners();
    return value;
  }

  bool isGrayScale() => storage.read(key_grayscale) ?? false;

  bool toggleGrayScale() {
    bool value = !isGrayScale();
    storage.write(key_grayscale, value);
    notifyListeners();
    return value;
  }

  int getGridLayout() => storage.read(key_gridlayout) ?? threeImageGrid;

  int toggleGridLayout() {
    int gridLayout = storage.read(key_gridlayout) ?? threeImageGrid;
    gridLayout =
        gridLayout >= threeImageGrid ? singleImageGrid : gridLayout + 1;
    storage.write(key_gridlayout, gridLayout);
    notifyListeners();
    return gridLayout;
  }

  int getFontSize() =>
      (storage.read(key_font_size) ?? default_font_size).toInt();

  void setFontSize(int value) {
    storage.write(key_font_size, value);
    notifyListeners();
  }
}
