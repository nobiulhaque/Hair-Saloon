// ReportProvider.dart

import 'package:flutter/material.dart';
import 'package:hair_saloon/admin/presentation/admin_pages/reports/model/reportModel.dart';
// Assuming ReportService.dart and ReportData.dart (or combined ReportService.dart) are available

class ReportProvider extends ChangeNotifier {
  // === State Variables ===
  String _selectedTimeFrame = 'Today';
  List<EmployeeReport> _allReports = [];
  bool _isLoading = true;
  String? _errorMessage;

  // === Getters for UI access ===
  String get selectedTimeFrame => _selectedTimeFrame;
  List<EmployeeReport> get allReports => _allReports;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  // === Initial Load ===
  ReportProvider() {
    fetchReports();
  }

  // === Data Fetching Logic (using the service) ===
  Future<void> fetchReports() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final reports = await ReportService.fetchReports();
      _allReports = reports;
    } catch (e) {
      _errorMessage = e.toString();
      _allReports = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // === Action: Update Dropdown Selection ===
  void setSelectedTimeFrame(String? newTimeFrame) {
    if (newTimeFrame != null && _selectedTimeFrame != newTimeFrame) {
      _selectedTimeFrame = newTimeFrame;
      notifyListeners();
    }
  }

  // === Filtering Logic (Business Logic) ===
  List<EmployeeReport> get filteredReports {
    if (_allReports.isEmpty) return [];

    String expectedType;
    switch (_selectedTimeFrame) {
      case 'Today':
        expectedType = 'daily';
        break;
      case 'Weekly':
        expectedType = 'weekly';
        break;
      case 'Monthly':
        expectedType = 'monthly';
        break;
      default:
        return [];
    }
    return _allReports.where((r) => r.reportType == expectedType).toList();
  }
}