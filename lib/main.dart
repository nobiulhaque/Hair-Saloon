import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hair_saloon/admin/presentation/admin_pages/services_page/provider/service_provider.dart';
import 'package:provider/provider.dart';
import 'package:hair_saloon/core/service/booking_provider.dart';
import 'package:hair_saloon/core/service/chipprovider.dart';
import 'package:hair_saloon/core/theme/theme.dart';
import 'package:hair_saloon/routes/app_routes.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ChipProvider()),
        ChangeNotifierProvider(create: (_) => BookingProvider()),
        ChangeNotifierProvider(create: (_) => ServiceProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Hair Salon App',
      theme: HsAppTheme.lightTheme,
      themeMode: ThemeMode.system,
      initialRoute: AppRoutes.hiddenDrawer,
      getPages: AppRoutes.routes,
    );
  }
}
