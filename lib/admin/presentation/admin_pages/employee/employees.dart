import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hair_saloon/admin/presentation/admin_pages/employee/utils/employee_card.dart';
import 'package:hair_saloon/admin/presentation/admin_pages/employee/utils/employee_data.dart';
import 'package:hair_saloon/core/widgets/card1.dart';

class Employees extends StatelessWidget {
  const Employees({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
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
                onTap: () => Get.toNamed('/add_employee'),
                icon: Icons.group_add_outlined,
                label: 'Add Employees',
                sublabel: 'Total Employees: ${employees.length}',
                color: Colors.grey.shade200,
              ),
              const SizedBox(height: 10),

              // Divider line with elevation
              Material(
                elevation: 2,
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  height: 5,
                  width: 350,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 10),

              // Employee grid
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: ShaderMask(
                    shaderCallback: (rect) {
                      return const LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.white,
                          Colors.white,
                          Colors.transparent,
                        ],
                        stops: [0.0, 0.03, 0.95, 1.0],
                      ).createShader(rect);
                    },
                    blendMode: BlendMode.dstIn,
                    child: GridView.builder(
                      itemCount: employees.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 12,
                        crossAxisSpacing: 12,
                        childAspectRatio: 0.9,
                      ),
                      itemBuilder: (context, index) {
                        final emp = employees[index];
                        return EmployeeCard(
                          name: emp['name'] ?? '',
                          phone: emp['phone'] ?? '',
                          email: emp['email'] ?? '',
                          onEdit: () {
                            // Add edit functionality
                          },
                          onDelete: () {
                            // Add delete functionality
                          },
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
