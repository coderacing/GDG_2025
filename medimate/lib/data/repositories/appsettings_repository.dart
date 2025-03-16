import '../providers/appsettings_provider.dart';

class AppSettingsRepository {
  final AppSettingsProvider appSettingsProvider;

  // ✅ Correct constructor initialization
  AppSettingsRepository({required this.appSettingsProvider});

  void setNightTheme(bool value) {
    appSettingsProvider.setNightTheme(value);
  }

  bool isNightTheme() {
    return appSettingsProvider.isNightTheme();
  }

  bool toggleTheme() {
    return appSettingsProvider.toggleTheme();
  }

  bool isGrayScale() {
    return appSettingsProvider.isGrayScale();
  }

  bool toggleGrayScale() {
    return appSettingsProvider.toggleGrayScale();
  }

  int getGridLayout() {
    return appSettingsProvider.getGridLayout();
  }

  int toggleGridLayout() {
    return appSettingsProvider.toggleGridLayout();
  }

  num getFontSize() {
    return appSettingsProvider.getFontSize();
  }

  void setFontSize(value) {
    appSettingsProvider.setFontSize(value);
  }
}
