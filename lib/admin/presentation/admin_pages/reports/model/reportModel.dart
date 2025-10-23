// ReportService.dart

import 'dart:async';
import 'package:intl/intl.dart';

// === DATA MODELS ===

class Employee {
  final String name;
  final String email;

  Employee({required this.name, required this.email});
}

class EmployeeReport {
  final Employee employee;
  final String reportType;
  final String dateGenerated;
  final int totalServices;
  final double totalAmount;
  // New field to hold the dynamic date string for display
  final String displayDateRange; 

  EmployeeReport({
    required this.employee,
    required this.reportType,
    required this.dateGenerated,
    required this.totalServices,
    required this.totalAmount,
    required this.displayDateRange, // Required in the constructor
  });

  // Factory method to create an EmployeeReport from raw API/Mock Map data
  factory EmployeeReport.fromMap(Map<String, dynamic> map) {
    // Current date is 2025-10-22
    final DateTime today = DateTime(2025, 10, 22); 
    final String reportType = map['report_type'];
    final String staticDate = map['date_generated'];
    String displayDate;

    // Logic to set the dynamic date range
    if (reportType == 'daily') {
        // Today: Show only the current date
        displayDate = DateFormat('yyyy-MM-dd').format(today);
    } else if (reportType == 'weekly') {
        // Weekly: Show date_generated to Today
        displayDate = '$staticDate \n to \n ${DateFormat('yyyy-MM-dd').format(today)}';
    } else if (reportType == 'monthly') {
        // Monthly: Show date_generated to Today
        displayDate = '$staticDate \n to \n ${DateFormat('yyyy-MM-dd').format(today)}';
    } else {
        displayDate = staticDate;
    }

    return EmployeeReport(
      employee: Employee(
        name: map['employee']['name'],
        email: map['employee']['email'],
      ),
      reportType: reportType,
      dateGenerated: staticDate,
      totalServices: map['total_services'],
      totalAmount: map['total_amount'] is int 
          ? (map['total_amount'] as int).toDouble() 
          : map['total_amount'],
      displayDateRange: displayDate, // Assign the calculated date string
    );
  }
}

// === MOCK SERVICE LOGIC ===

class ReportService {
  static final List<Map<String, dynamic>> _mockReportsData = [
    // Today Reports (daily) - dateGenerated is irrelevant for display, but kept for data structure
    {
      'employee': {'name': 'Rahim Uddin', 'email': 'rahim@example.com'},
      'report_type': 'daily',
      'date_generated': '2025-10-22', // Today's date
      'total_services': 12,
      'total_amount': 2500.00,
    },
    {
      'employee': {'name': 'Abdul Kalam', 'email': 'abdul.k@example.com'},
      'report_type': 'daily',
      'date_generated': '2025-10-22', // Today's date
      'total_services': 9,
      'total_amount': 1850.50,
    },

    // Weekly Reports (start date 7 days ago, e.g., Oct 15)
    {
      'employee': {'name': 'Karim Mia', 'email': 'karim@example.com'},
      'report_type': 'weekly',
      'date_generated': '2025-10-15', 
      'total_services': 65,
      'total_amount': 12500.00,
    },
    {
      'employee': {'name': 'Farid Ahmed', 'email': 'farid.a@example.com'},
      'report_type': 'weekly',
      'date_generated': '2025-10-08',
      'total_services': 72,
      'total_amount': 15500.75,
    },

    // Monthly Reports (start date a month ago, e.g., Sept 22/20)
    {
      'employee': {'name': 'Samiul Hoque', 'email': 'samiul.h@example.com'},
      'report_type': 'monthly',
      'date_generated': '2025-09-22', 
      'total_services': 310,
      'total_amount': 61500.00,
    },
    {
      'employee': {'name': 'Masud Rana', 'email': 'masud.r@example.com'},
      'report_type': 'monthly',
      'date_generated': '2025-09-20',
      'total_services': 255,
      'total_amount': 48900.25,
    },
    // Adding back a monthly report with the original date for consistency
    {
      'employee': {'name': 'Sumi Akter', 'email': 'sumi@example.com'},
      'report_type': 'monthly',
      'date_generated': '2025-09-30',
      'total_services': 280,
      'total_amount': 53000.00,
    },
  ];

  static Future<List<EmployeeReport>> fetchReports() async {
    await Future.delayed(const Duration(milliseconds: 500)); 
    return _mockReportsData.map((data) => EmployeeReport.fromMap(data)).toList();
  }
}