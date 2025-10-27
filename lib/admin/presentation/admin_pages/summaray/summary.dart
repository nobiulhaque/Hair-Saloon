import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hair_saloon/admin/presentation/admin_pages/summaray/controller/dashboard_controller.dart';

// --- MAIN SUMMARY WIDGET ---

class Summary extends StatelessWidget {
  const Summary({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize and retrieve the controller
    final DashboardController controller = Get.put(DashboardController());

    return Scaffold(
      backgroundColor: const Color(0xFFF7F9FC),
      body: SafeArea(
        child: Obx(() {
          final data = controller.dashboardData.value;
          final isLoading = controller.isLoading.isTrue;

          // 1. Initial Loading/Loading after a forced refresh (when data is null)
          if (data == null && isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          // 2. No Data Available (fetch completed but returned null)
          if (data == null && !isLoading) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'No dashboard data available.',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: controller.fetchDashboardData,
                    child: const Text('Try Again'),
                  ),
                ],
              ),
            );
          }
          

          // KPI cards data
          final List<KpiData> kpis = [
            KpiData(
              title: 'Total Revenue',
              value: '\$${data.totalRevenue.toStringAsFixed(2)}',
              icon: Icons.attach_money_rounded,
              color: const Color(0xFF1E88E5),
            ),
            KpiData(
              title: 'Appointments',
              value: data.totalAppointments.toString(),
              icon: Icons.calendar_today_rounded,
              color: const Color(0xFF43A047),
            ),
            KpiData(
              title: 'Active Employees',
              value: data.activeEmployees.toString(),
              icon: Icons.people_alt_rounded,
              color: const Color(0xFFD81B60),
            ),
            KpiData(
              title: 'Org. Balance',
              value: '\$${data.organizationBalance.toStringAsFixed(2)}',
              icon: Icons.account_balance_wallet_rounded,
              color: const Color(0xFFFFB300),
            ),
          ];

          // 💡 Pull-to-Refresh Implementation
          return RefreshIndicator(
            onRefresh: controller.fetchDashboardData, // Function to call on swipe-down
            color: Colors.blueAccent, // Color of the refresh indicator
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(), // Allows pull-down even on short content
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  Text(
                    'Dashboard Overview',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade800,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Today: ${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}',
                    style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
                  ),
                  const SizedBox(height: 30),

                  // KPI Cards
                  Text(
                    'Key Performance Indicators',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey.shade800,
                    ),
                  ),
                  const SizedBox(height: 15),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: kpis.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 15,
                      mainAxisSpacing: 15,
                      childAspectRatio: 1.25,
                    ),
                    itemBuilder: (context, index) {
                      return _KpiCard(data: kpis[index]);
                    },
                  ),

                  const SizedBox(height: 40),

                  // Chart Placeholder
                  Text(
                    'Revenue Trend (Last 7 Days)',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey.shade800,
                    ),
                  ),
                  const SizedBox(height: 15),
                  Container(
                    height: 200,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: Colors.grey.shade200),
                    ),
                    child: const Center(
                      child: Text(
                        '📊 Chart Placeholder',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}

// --- HELPER MODEL CLASS FOR KPI DATA ---

class KpiData {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  KpiData({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });
}

// --- HELPER WIDGET FOR KPI CARD ---

class _KpiCard extends StatelessWidget {
  final KpiData data;
  const _KpiCard({required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: data.color.withAlpha(40),
            spreadRadius: 1,
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: data.color.withOpacity(0.1),
            child: Icon(data.icon, color: data.color, size: 20),
          ),
          const SizedBox(height: 10),
          Text(
            data.value,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade800,
            ),
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            data.title,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade600,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}