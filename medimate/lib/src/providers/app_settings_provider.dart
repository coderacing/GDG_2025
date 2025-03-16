import 'package:get_storage/get_storage.dart';
import 'package:medimate/src/utils/const.dart';

class AppSettingsProvider {
  static AppSettingsProvider instance = AppSettingsProvider._();

  AppSettingsProvider._();

  // Shared preference
  GetStorage storage = GetStorage();

  isNightTheme() => storage.read(key_night_mode) ?? false;

  setNightTheme(bool value) {
    storage.write(key_night_mode, value);
  }

  bool toggleTheme() {
    bool value = !isNightTheme();
    storage.write(key_night_mode, value);
    return value;
  }

  isGrayScale() => storage.read(key_grayscale) ?? false;

  bool toggleGrayScale() {
    bool value = !isGrayScale();
    storage.write(key_grayscale, value);
    return value;
  }

  int getGridLayout() => storage.read(key_gridlayout) ?? threeImageGrid;

  int toggleGridLayout() {
    int gridLayout = storage.read(key_gridlayout) ?? threeImageGrid;
    gridLayout++;
    gridLayout = gridLayout > threeImageGrid ? singleImageGrid : gridLayout;
    storage.write(key_gridlayout, gridLayout);
    return gridLayout;
  }

  int getFontSize() => storage.read(key_font_size) ?? default_font_size;

  void setFontSize(int value) {
    storage.write(key_font_size, value);
  }

  /// isRemoveAds
  isRemoveAds() =>
      storage.read(key_remove_ads) ??
      false; // set to true only for debugging - revert back to false

  setRemoveAds(bool value) {
    storage.write(key_remove_ads, value);
  }
}
