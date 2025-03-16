import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medimate/logic/cubit/settings/appsettings_cubit.dart';
import 'package:medimate/src/utils/const.dart';

class FontSizeWidget extends StatelessWidget {
  const FontSizeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppsettingsCubit, AppsettingsState>(
      builder: (context, state) {
        return ExpansionTile(
          title: const Text('Font size'),
          subtitle: Text(state.fontSize.toString()),
          children: [
            Slider(
                value: state.fontSize.toDouble(),
                min: 8,
                max: 64,
                onChanged: (value) {
                  context.read<AppsettingsCubit>().setFontSize(value.toInt());
                }),
            ElevatedButton(
                onPressed: () {
                  context
                      .read<AppsettingsCubit>()
                      .setFontSize(default_font_size);
                },
                child: const Text('Reset')),
          ],
        );
      },
    );
  }
}
