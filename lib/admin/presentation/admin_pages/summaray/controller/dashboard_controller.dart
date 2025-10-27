import 'package:get/get.dart';
import 'package:hair_saloon/admin/presentation/admin_pages/summaray/service/dashboard_api.dart';
import 'package:hair_saloon/admin/presentation/admin_pages/summaray/service/model.dart';

class DashboardController extends GetxController {
  /// Observable data for UI
  var dashboardData = DashboardData().obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchDashboardData();
  }

  Future<void> fetchDashboardData() async {
    isLoading.value = true;

    try {
      // Fetch raw data from API
      final rawData = await DashboardApi.fetchDashboardData();

      // --- Data Processing / Aggregation ---

      // 1️⃣ Transactions → Revenue & Appointments
      final List transactions = rawData['transactions'] ?? [];
      double totalRevenue = 0.0;
      for (var t in transactions) {
        totalRevenue += (t['amount'] as num?)?.toDouble() ?? 0.0;
      }
      final totalAppointments = transactions.length;

      // 2️⃣ Employees
      final List employees = rawData['employees'] ?? [];
      final activeEmployees = employees.length;

      // 3️⃣ Balance
      final List balances = rawData['balance'] ?? [];
      final organizationBalance = (balances.isNotEmpty
          ? (balances.first['balance'] as num?)?.toDouble() ?? 0.0
          : 0.0);

      // ✅ Update the observable model
      dashboardData.value = DashboardData(
        totalRevenue: totalRevenue,
        totalAppointments: totalAppointments,
        activeEmployees: activeEmployees,
        organizationBalance: organizationBalance,
      );
    } catch (e) {
      Get.snackbar('Error', 'Failed to load dashboard data: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
