import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hair_saloon/admin/presentation/admin_pages/reports/controller/reportProvider.dart';
import 'package:hair_saloon/admin/presentation/admin_pages/services_page/provider/service_provider.dart';
import 'package:hair_saloon/core/service/storage_service.dart';
import 'package:hair_saloon/routes/app_routes.dart';
import 'package:provider/provider.dart';
import 'package:hair_saloon/core/service/booking_provider.dart';
import 'package:hair_saloon/core/service/chipprovider.dart';
import 'package:hair_saloon/core/theme/theme.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await StorageService.init();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ChipProvider()),
        ChangeNotifierProvider(create: (_) => BookingProvider()),
        ChangeNotifierProvider(create: (_) => ServiceProvider()),
        ChangeNotifierProvider(create: (_) => ReportProvider()),
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

      // home: SigninPage(),
    );
  }
}
