class DashboardData {
  final double totalRevenue;
  final int totalAppointments;
  final int activeEmployees;
  final double organizationBalance;

  DashboardData({
    this.totalRevenue = 0.0,
    this.totalAppointments = 0,
    this.activeEmployees = 0,
    this.organizationBalance = 0.0,
  });

  /// Create DashboardData from backend JSON
  factory DashboardData.fromJson(Map<String, dynamic> json) {
    return DashboardData(
      totalRevenue: (json['totalRevenue'] ?? 0).toDouble(),
      totalAppointments: json['totalAppointments'] ?? 0,
      activeEmployees: json['activeEmployees'] ?? 0,
      organizationBalance: (json['organizationBalance'] ?? 0).toDouble(),
    );
  }

  /// Convert model back to JSON (optional but handy)
  Map<String, dynamic> toJson() => {
        'totalRevenue': totalRevenue,
        'totalAppointments': totalAppointments,
        'activeEmployees': activeEmployees,
        'organizationBalance': organizationBalance,
      };
}
