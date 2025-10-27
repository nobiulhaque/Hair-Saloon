import 'dart:convert';
import 'package:hair_saloon/core/service/api_constants.dart';
import 'package:http/http.dart' as http;


class DashboardApi {
  /// Fetch and combine data from multiple endpoints
  static Future<Map<String, dynamic>> fetchDashboardData() async {
    try {
      final transactionsResponse = await http.get(
        Uri.parse('${ApiConstants.baseUrl}/transaction/transactions/'),
      );
      final employeesResponse = await http.get(
        Uri.parse('${ApiConstants.baseUrl}/employee/employees/'),
      );
      final balanceResponse = await http.get(
        Uri.parse('${ApiConstants.baseUrl}/balance/organization-balances/'),
      );

      if (transactionsResponse.statusCode != 200 ||
          employeesResponse.statusCode != 200 ||
          balanceResponse.statusCode != 200) {
        throw Exception('One or more requests failed');
      }

      final transactionsData = jsonDecode(transactionsResponse.body);
      final employeesData = jsonDecode(employeesResponse.body);
      final balanceData = jsonDecode(balanceResponse.body);

      return {
        'transactions': transactionsData,
        'employees': employeesData,
        'balance': balanceData,
      };
    } catch (e) {
      throw Exception('Failed to fetch dashboard data: $e');
    }
  }

  /// ✅ Alias for backward compatibility with older controller versions
  static Future<Map<String, dynamic>> fetchDashboardRawData() =>
      fetchDashboardData();
}
