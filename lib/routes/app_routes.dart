import 'package:get/get.dart';
import 'package:hair_saloon/hdm/presentation/hidden_drawer_menu.dart';
import 'package:hair_saloon/home/presentation/home_page.dart';

class AppRoutes {
  // Define route names
  static const String hiddenDrawer = '/';
  static const String home = '/home';

  // Define route pages
  static final routes = [
    GetPage(
      name: hiddenDrawer,
      page: () => const AppHiddenDrawerMenu(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: home,
      page: () => const HomePage(),
      transition: Transition.rightToLeft,
    ),
  ];
}
