import 'package:flutter/material.dart';
import 'package:hair_saloon/core/widgets/card1.dart';

class Employees extends StatelessWidget {
  const Employees({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.green, // A very light green
              Colors.white, // White
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Card1(
                onTap: () {},
                icon: Icons.group_add_outlined,
                label: 'Add Employees',
                sublabel: 'Total Employees: 10',
                color: Colors.grey.shade200,
              ),
              SizedBox(height: 10),
              Card1(
                onTap: () {},
                icon: Icons.person,
                label: 'Employee Details',
                sublabel: 'View and edit employee details',
                color: Colors.grey.shade200,
              ),
              SizedBox(height: 10),
              Card1(
                onTap: () {},
                icon: Icons.edit,
                label: 'Edit or Remove Employee',
                sublabel: 'Manage employee records',
                color: Colors.grey.shade200,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
