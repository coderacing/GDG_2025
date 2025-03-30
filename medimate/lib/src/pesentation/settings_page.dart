import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medimate/src/widgets/daynightmode_widget.dart';
import 'package:medimate/src/widgets/fontsize_widget.dart';
import 'package:medimate/theme/mm_theme.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key, this.title});

  static const String routeName = "/SettignsPage";

  final String? title;

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

/// // 1. After the page has been created, register it with the app routes
/// routes: <String, WidgetBuilder>{
///   SettignsPage.routeName: (BuildContext context) => new SettignsPage(title: "SettignsPage"),
/// },
///
/// // 2. Then this could be used to navigate to the page.
/// Navigator.pushNamed(context, SettignsPage.routeName);
///

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title ?? ''),
      ),
      body: ListView(
        children: const [
          DayNightModeWidget(),
          Divider(
            color: Color.fromARGB(255, 248, 187, 208),
          ),
          FontSizeWidget(),
          Divider(
            color: Color.fromARGB(255, 248, 187, 208),
          ),
        ],
      ),
    );
  }
}
