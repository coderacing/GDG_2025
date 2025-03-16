part of 'appsettings_cubit.dart';

class AppsettingsState extends Equatable {
  final bool useNightTheme;
  final bool grayScale;
  final int gridLayout;
  final int fontSize;

  const AppsettingsState(
      {this.useNightTheme = false,
      this.grayScale = false,
      this.gridLayout = threeImageGrid,
      this.fontSize = default_font_size});

  isNightTheme() => useNightTheme;
  isGrayScale() => grayScale;
  gridImageLayout() => gridLayout;
  getFontSize() => fontSize;

  @override
  List<Object> get props => [useNightTheme, grayScale, gridLayout, fontSize];

  AppsettingsState copyWith(
      {bool? useNightTheme, bool? grayScale, int? gridLayout, int? fontSize}) {
    return AppsettingsState(
        useNightTheme: useNightTheme ?? this.useNightTheme,
        grayScale: grayScale ?? this.grayScale,
        gridLayout: gridLayout ?? this.gridLayout,
        fontSize: fontSize ?? this.fontSize);
  }
}
