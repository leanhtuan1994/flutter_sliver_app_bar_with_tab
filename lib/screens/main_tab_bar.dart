import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'alarm_screen.dart';
import 'bag_screen.dart';
import 'home_screen.dart';

class MainTabBar extends StatelessWidget {
  const MainTabBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      screens: _buildScreens(),
      items: _navBarItems(),
      navBarStyle: NavBarStyle.style12,
      backgroundColor: Colors.white,
      decoration: NavBarDecoration(
        border: Border.all(color: Colors.grey, width: 0.1),
      ),
    );
  }

  List<Widget> _buildScreens() {
    return [HomeScreen(), BagScreen(), AlarmScreen(), Container()];
  }

  List<PersistentBottomNavBarItem> _navBarItems() {
    return [
      _navBarItem(CupertinoIcons.home, 'Home'),
      _navBarItem(CupertinoIcons.bag, 'Bag'),
      _navBarItem(CupertinoIcons.alarm, 'Alarm'),
      _navBarItem(CupertinoIcons.settings, 'Setting'),
    ];
  }

  PersistentBottomNavBarItem _navBarItem(IconData icon, String? title) {
    return PersistentBottomNavBarItem(
        icon: Icon(icon),
        title: title,
        activeColorPrimary: CupertinoColors.activeBlue,
        inactiveColorPrimary: CupertinoColors.systemGrey);
  }
}
