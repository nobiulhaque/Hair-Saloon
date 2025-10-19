import 'package:flutter/material.dart';
import 'package:hair_saloon/core/widgets/card1.dart';

class Reports extends StatelessWidget {
  const Reports({super.key});

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
                icon: Icons.analytics_outlined,
                label: 'Daily Report',
                sublabel: 'Daily Service: 150৳',
                color: Colors.grey.shade200,
              ),
              SizedBox(height: 10),
              Card1(
                onTap: () {},
                icon: Icons.analytics_outlined,
                label: 'Weekly Report',
                sublabel: 'Weekly Service: 3500৳',
                color: Colors.grey.shade200,
              ),
              SizedBox(height: 10),
              Card1(
                onTap: () {},
                icon: Icons.analytics_outlined,
                label: 'Monthly Report',
                sublabel: 'Monthly Service: 16000৳',
                color: Colors.grey.shade200,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
