import 'package:flutter/material.dart';
import 'package:hair_saloon/core/widgets/info_card.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.green, // Top color
              Colors.white, // Bottom color
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 30),

                // --- Profile Section ---
                const CircleAvatar(
                  radius: 50,
                  backgroundColor:
                      Colors.greenAccent, // background color of the circle
                  child: Icon(Icons.person, size: 50, color: Colors.green),
                  // backgroundImage: AssetImage('assets/images/profile.png'), // uncomment if you use an image
                ),

                const SizedBox(height: 10),
                const Text(
                  'Owner Name',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 40),

                // --- Settings Options ---
                InfoCard(
                  title: 'Account Settings',
                  icon: Icons.settings,
                  color: Colors.green,
                  onTap: () {
                    // Navigate to account settings page
                  },
                ),
                SizedBox(height: 5),
                InfoCard(
                  title: 'Notification',
                  icon: Icons.notifications,
                  color: Colors.green,
                  onTap: () {
                    // Navigate to account settings page
                  },
                ),
                SizedBox(height: 5),
                InfoCard(
                  title: 'Privacy',
                  icon: Icons.lock,
                  color: Colors.green,
                  onTap: () {
                    // Navigate to account settings page
                  },
                ),
                const Spacer(),

                // --- Logout Button ---
                ElevatedButton.icon(
                  onPressed: () {
                    // Handle logout logic here
                  },
                  icon: const Icon(Icons.logout),
                  label: const Text('Logout'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green.shade700,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 14,
                    ),
                    textStyle: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
