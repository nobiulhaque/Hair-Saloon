import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:hair_saloon/admin/presentation/admin_pages/employee/employees.dart';
import 'package:hair_saloon/admin/presentation/admin_pages/reports/reports.dart';
import 'package:hair_saloon/admin/presentation/admin_pages/services_page/services_pages.dart';
import 'package:hair_saloon/admin/presentation/admin_pages/settings.dart';
import 'package:hair_saloon/admin/presentation/admin_pages/summaray/summary.dart';

class Admin extends StatefulWidget {
  const Admin({super.key});

  @override
  State<Admin> createState() => _AdminState();
}

class _AdminState extends State<Admin> {
  int index = 2;

  final screens = [
    const Reports(),
    const Employees(),
    const Summary(),
    const Services(),
    const Settings(),
  ];

  @override
  Widget build(BuildContext context) {
    final items = <Widget>[
      const Icon(Icons.bar_chart, size: 28),
      const Icon(Icons.people, size: 28),
      const Icon(Icons.dashboard, size: 28),
      const Icon(Icons.design_services_outlined, size: 28),
      const Icon(Icons.settings, size: 28),
    ];

    return Scaffold(
      extendBody: true,
      body: IndexedStack(
        index: index,
        children: screens,
      ),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        child: CurvedNavigationBar(
          backgroundColor: Colors.transparent,
          color: Colors.green,
          buttonBackgroundColor: Colors.green.shade600,
          height: 65,
          index: index,
          animationCurve: Curves.easeInOut,
          animationDuration: const Duration(milliseconds: 400),
          items: items,
          onTap: (newIndex) {
            setState(() {
              index = newIndex;
            });
          },
        ),
      ),
    );
  }
}
