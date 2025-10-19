import 'package:flutter/material.dart';
import 'package:hair_saloon/core/widgets/card1.dart';

class Summary extends StatelessWidget {
  const Summary({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.green, Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Card1(
                onTap: () {},
                icon: Icons.event,
                label: 'Total Appointments',
                sublabel: '150',
                color: Colors.grey.shade200,
              ),
              SizedBox(height: 10),
              Card1(
                onTap: () {},
                icon: Icons.monetization_on,
                label: 'Payments',
                sublabel: 'Owner - 30%, Staff - 70%',
                color: Colors.grey.shade200,
              ),
              SizedBox(height: 10),
              Card1(
                onTap: () {},
                icon: Icons.inventory,
                label: 'Inventory',
                sublabel: 'Total Items: 250',
                color: Colors.grey.shade200,
              ),
              SizedBox(height: 10),
              Card1(
                onTap: () {},
                icon: Icons.feedback,
                label: 'Employee Activity Overview',
                sublabel: 'Active Employees: 8, Inactive Employees: 2',
                color: Colors.grey.shade200,
              ),
              SizedBox(height: 40),
              Text(
                "Owner: John Doe",
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
              ),
              Text(
                "Location: 123 Main St, Cityville",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
