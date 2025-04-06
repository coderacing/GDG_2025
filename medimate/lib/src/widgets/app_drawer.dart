import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medimate/src/pesentation/about_page.dart';
import 'package:medimate/src/pesentation/homepage.dart';
import 'package:medimate/src/pesentation/nearest_pharmacy%20.dart';
import 'package:medimate/src/pesentation/settings_page.dart';
import 'package:medimate/src/widgets/bkg_img_widget.dart';

class AppDrawer extends StatefulWidget {
  static const int HOME_INDEX = 0;
  static const int NEAREST_PHARMACY_INDEX = 1;
  static const int SETTINGS_INDEX = 2;
  static const int ABOUT_INDEX = 3;

  final int? selectedIndex;

  const AppDrawer({super.key, this.selectedIndex});

  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  late int selectedIndex;

  final List<Map<String, dynamic>> _drawerItems = [
    {
      "title": "Home",
      "icon": Icons.home,
      "subtitle": "Back to homepage",
      "route": HomePage.routeName,
    },
    {
      "title": "Nearest Pharmacy",
      "icon": Icons.local_pharmacy,
      "subtitle": "Find nearest pharmacy",
      "route": NearestPharmacyPage.routeName,
    },
    {
      "title": "Settings",
      "icon": Icons.settings,
      "subtitle": "Set your app settings",
      "route": SettingsPage.routeName,
    },
    {
      "title": "About",
      "subtitle": "Behind the scenes",
      "icon": Icons.info,
      "route": AboutPage.routeName,
    },
  ];

  @override
  void initState() {
    super.initState();
    selectedIndex = widget.selectedIndex ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Drawer(
      child: Container(
        color: isDarkMode ? const Color.fromARGB(255, 20, 0, 21) : null,
        child: BkgImgWidget(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              _buildDrawerHeader(isDarkMode),
              ..._buildDrawerItems(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDrawerHeader(bool isDarkMode) {
    return DrawerHeader(
      decoration: BoxDecoration(
        color: isDarkMode
            ? const Color.fromARGB(255, 211, 106, 238)
            : const Color.fromARGB(255, 229, 170, 244),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset('assets/images/app_logo.png', width: 80.0, height: 80.0),
          const SizedBox(height: 10),
          const Text(
            'Medimate',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildDrawerItems() {
    return List.generate(_drawerItems.length, (index) {
      final item = _drawerItems[index];
      return AppDrawerItem(
        title: item["title"],
        subtitle: item["subtitle"],
        icons: item["icon"],
        routeName: item["route"],
        index: index,
        selectedIndex: selectedIndex,
        menuItemSelected: (int selIndex) {
          setState(() {
            Navigator.of(context).pop(); // Close the drawer
            if (selectedIndex != selIndex) {
              Get.toNamed(item["route"]);
              selectedIndex = selIndex;
            }
          });
        },
      );
    });
  }
}

class AppDrawerItem extends StatelessWidget {
  final String title;
  final String? subtitle;
  final IconData icons;
  final String routeName;
  final int index;
  final int selectedIndex;
  final ValueChanged<int> menuItemSelected;

  const AppDrawerItem({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icons,
    required this.routeName,
    required this.index,
    required this.selectedIndex,
    required this.menuItemSelected,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        icons,
        color: selectedIndex == index
            ? const Color.fromARGB(255, 229, 170, 244)
            : Colors.grey,
      ),
      title: Text(
        title,
        style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
      ),
      subtitle: subtitle != null ? Text(subtitle!) : null,
      selected: selectedIndex == index,
      selectedTileColor:
          const Color.fromARGB(255, 229, 170, 244).withOpacity(0.2),
      onTap: () {
        menuItemSelected(index);
      },
    );
  }
}
