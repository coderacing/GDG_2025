import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:medimate/logic/cubit/settings/appsettings_cubit.dart';
import 'package:medimate/src/pesentation/about_page.dart';
import 'package:medimate/src/pesentation/add_medi.dart';
import 'package:medimate/src/pesentation/homepage.dart';
import 'package:medimate/src/pesentation/settings_page.dart';
import 'package:medimate/src/pesentation/splashpage.dart';
import 'package:medimate/src/utils/const.dart';
import 'package:medimate/theme/mm_theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppsettingsCubit, AppsettingsState>(
      builder: (context, state) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          theme: (state.isNightTheme()
                  ? MMTheme.kGalleryDarkTheme
                  : MMTheme.kGalleryLightTheme)
              .copyWith(platform: defaultTargetPlatform),
          home: const SplashScreen(),
          getPages: [
            GetPage(
                name: HomePage.routeName,
                page: () => _applyScaleFactor(HomePage())),
            GetPage(
                name: SettingsPage.routeName,
                page: () => _applyScaleFactor(SettingsPage())),
            GetPage(
                name: AboutPage.routeName,
                page: () => _applyScaleFactor(const AboutPage())),
            GetPage(
                name: AddMedicineScreen.routeName,
                page: () => _applyScaleFactor(const AddMedicineScreen(
                      extractedText: '',
                    ))),
          ],
        );
      },
    );
  }

  Widget _applyScaleFactor(Widget child) {
    return BlocBuilder<AppsettingsCubit, AppsettingsState>(
      builder: (context, state) {
        return Builder(
          builder: (BuildContext context) => MediaQuery(
            data: MediaQuery.of(context).copyWith(
              textScaler:
                  TextScaler.linear(state.getFontSize() / default_font_size),
            ),
            child: child,
          ),
        );
      },
    );
  }
}
