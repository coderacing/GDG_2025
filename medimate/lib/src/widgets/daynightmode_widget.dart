import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medimate/logic/cubit/settings/appsettings_cubit.dart';

class DayNightModeWidget extends StatelessWidget {
  const DayNightModeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppsettingsCubit, AppsettingsState>(
      builder: (context, state) {
        return SwitchListTile(
          title: const Text('Use Night Mode'),
          subtitle: const Text('Changes the theme of the app'),
          onChanged: (bool newValue) {
            context.read<AppsettingsCubit>().toggleTheme();
          },
          value: state.useNightTheme,
        );
      },
    );
  }
}
