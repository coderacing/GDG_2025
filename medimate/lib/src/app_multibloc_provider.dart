import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medimate/data/repositories/appsettings_repository.dart';
import 'package:medimate/data/providers/appsettings_provider.dart'; // ✅ Import this
import 'package:medimate/logic/cubit/settings/appsettings_cubit.dart';
import 'package:medimate/src/appdart.dart';

class AppMultiBlocProvider extends StatelessWidget {
  const AppMultiBlocProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AppsettingsCubit>(
          create: (context) => AppsettingsCubit(AppSettingsRepository(
                  appSettingsProvider:
                      AppSettingsProvider()) // ✅ Pass required argument
              )
            ..init(),
        ),
      ],
      child: const MyApp(),
    );
  }
}
