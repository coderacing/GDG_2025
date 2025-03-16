import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:medimate/data/repositories/appsettings_repository.dart';
import 'package:medimate/src/utils/const.dart';

part 'appsettings_state.dart';

class AppsettingsCubit extends Cubit<AppsettingsState> {
  final AppSettingsRepository appSettingsRepository;

  AppsettingsCubit(this.appSettingsRepository)
      : super(const AppsettingsState());

  init() {
    bool useNightTheme = isNightTheme();
    bool grayScale = isGrayScale();
    int gridLayout = getGridLayout();
    int fontSize = getFontSize();

    emit(AppsettingsState(
        useNightTheme: useNightTheme,
        grayScale: grayScale,
        gridLayout: gridLayout,
        fontSize: fontSize));
  }

  bool isNightTheme() {
    return appSettingsRepository.isNightTheme();
  }

  void toggleTheme() {
    bool value = appSettingsRepository.toggleTheme();
    emit(state.copyWith(useNightTheme: value));
  }

  bool isGrayScale() {
    return appSettingsRepository.isGrayScale();
  }

  void toggleGrayScale() {
    bool value = appSettingsRepository.toggleGrayScale();
    emit(state.copyWith(grayScale: value));
  }

  int getGridLayout() {
    return appSettingsRepository.getGridLayout();
  }

  void toggleGridImageLayout() {
    int value = appSettingsRepository.toggleGridLayout();
    emit(state.copyWith(gridLayout: value));
  }

  int getFontSize() {
    return appSettingsRepository
        .getFontSize()
        .toInt(); // Ensure it returns an int
  }

  void setFontSize(int value) {
    appSettingsRepository.setFontSize(value);
    emit(state.copyWith(fontSize: value));
  }
}
