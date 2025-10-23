import 'package:flutter/material.dart';
import 'package:hair_saloon/admin/presentation/admin.dart';
import 'package:hair_saloon/home/presentation/home_page.dart';
import 'package:hidden_drawer_menu/hidden_drawer_menu.dart' as hd;

class AppHiddenDrawerMenu extends StatefulWidget {
  const AppHiddenDrawerMenu({super.key});

  @override
  State<AppHiddenDrawerMenu> createState() => _AppHiddenDrawerMenuState();
}

class _AppHiddenDrawerMenuState extends State<AppHiddenDrawerMenu> {
  late List<hd.ScreenHiddenDrawer> screens;

  @override
  void initState() {
    super.initState();

    screens = [
      // Home Page Screen WITHOUT AppBar
      hd.ScreenHiddenDrawer(
        hd.ItemHiddenMenu(
          colorLineSelected: Colors.white,
          name: 'Hair Salon',
          baseStyle: const TextStyle(
            color: Colors.white70,
            fontSize: 18,
            fontWeight: FontWeight.w400,
          ),
          selectedStyle: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Scaffold(
          body: HomePage(),
        ),
      ),
      // Admin Page Screen WITHOUT AppBar
      hd.ScreenHiddenDrawer(
        hd.ItemHiddenMenu(
          colorLineSelected: Colors.white,
          name: 'Admin',
          baseStyle: const TextStyle(
            color: Colors.white70,
            fontSize: 18,
            fontWeight: FontWeight.w400,
          ),
          selectedStyle: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Scaffold(
          body: Admin(),
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return hd.HiddenDrawerMenu(
      backgroundColorMenu: Colors.green.shade600,
      screens: screens,
      initPositionSelected: 0,
      slidePercent: 50.0,
      contentCornerRadius: 40.0,
      withShadow: true,
    );
  }
}
