import 'package:flutter/material.dart';
import 'package:medimate/src/widgets/bkg_img_widget.dart';
import 'package:medimate/theme/mm_theme.dart';

final menu_liturgy_index = 1;
final menu_members_index = 2;
final menu_place_index = 3;
final menu_history_index = 4;
final menu_favourite_index = 5;
final menu_settings_index = 6;
final menu_about_index = 7;

class AppDrawer extends StatefulWidget {
  static int LITURGY_INDEX = 0;
  static int PLACES_INDEX = 1;
  static int MEMBERS_INDEX = 2;
  static int CELEBRATIONS_INDEX = 3;
  static int HISTORY_INDEX = 4;
  static int FAVOURITE_INDEX = 5;
  static int SETTINGS_INDEX = 6;
  static int ABOUT_INDEX = 7;

  final int? selectedIndex;
  AppDrawer({this.selectedIndex});

  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  static int selectedIndex = 0;

  List<String> _drawerMenuItemTitles = [
    "Liturgy",
    "Places",
    "Members",
    "Celebrations",
    "History",
    "Favourite",
    "Settings",
    "About"
  ];

  List<IconData> _drawerMenuItemIcons = [
    Icons.chrome_reader_mode,
    Icons.place,
    Icons.group,
    Icons.star,
    Icons.history,
    Icons.favorite,
    Icons.settings,
    Icons.info_outline,
  ];

  List<String> _drawerMenuItemSubtitles = [
    "Daily Mass readings",
    "Presence across globe",
    "Details of CMI Members",
    "Daily joyful occassions",
    "A timeline of our growth",
    "Your favourite prayers",
    "Set your app settings",
    "Behind the scences"
  ];

  // List<String> _drawerMenuItemRoutes = [
  //   LiturgyPage.routeName,
  //   PlacesPage.routeName,
  //   MembersPage.routeName,
  //   CelebrationsPage.routeName,
  //   HistoryPage.routeName,
  //   PrayersFavouritePage.routeName,
  //   SettingsPage.routeName,
  //   AboutPage.routeName,
  // ];

  _buildAppDrawerItems() {
    int index = -1;
    return _drawerMenuItemTitles.map((String title) {
      ++index;
      return AppDrawerItem(
        title: title,
        icons: _drawerMenuItemIcons[index],
        subtitle: _drawerMenuItemSubtitles[index],
        // routeName: _drawerMenuItemRoutes[index],
        index: index,
        selectedIndex: selectedIndex,
        menuItemSelected: (int selIndex) {
          setState(() {
            selectedIndex = selIndex;
          });
        },
      );
    }).toList();
  }

  @override
  void initState() {
    super.initState();
    if (null != widget.selectedIndex && widget.selectedIndex != 0) {
      selectedIndex = widget.selectedIndex!;
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _widgets = [];
    Widget _drawerHeader = DrawerHeader(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Image.asset('assets/images/cmilogo_sm_white.png',
              width: 100.0, height: 100.0),
          Padding(
            padding: const EdgeInsets.only(
              left: 8.0,
              top: 8.0,
            ),
            child: Text('CMI Global',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24.0,
                )),
          ),
        ],
      ),
      decoration: BoxDecoration(
        color: MMTheme.blue,
      ),
    );

    _widgets.add(_drawerHeader);
    _widgets.addAll(_buildAppDrawerItems());

    return Drawer(
      child: BkgImgWidget(
        child: ListView(
          padding: new EdgeInsets.all(0.0),
          children: _widgets,
        ),
      ),
    );
  }
}

class AppDrawerItem extends StatelessWidget {
  String? title, subtitle;
  IconData? icons;
  String? routeName;
  int index, selectedIndex;
  ValueChanged<int> menuItemSelected;

  AppDrawerItem(
      {@required this.title,
      @required this.subtitle,
      @required this.icons,
      @required this.routeName,
      required this.index,
      required this.selectedIndex,
      required this.menuItemSelected});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icons),
      title: Text(title!),
      subtitle: Text(subtitle!),
      onTap: () {
        menuItemSelected(index);
        Navigator.of(context).pushNamed(routeName!);
      },
      selected: (selectedIndex == index),
    );
  }
}
