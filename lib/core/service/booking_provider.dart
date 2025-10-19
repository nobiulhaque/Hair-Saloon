
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BookingProvider with ChangeNotifier {
  // Shared Preferences keys for customer name logic
  static const String _customerKey = 'daily_customer_count';
  static const String _dateKey = 'last_reset_date';

  // State
  int _finalPrice = 0;
  String _customerName = '';
  String? _bookingError;
  String _defaultCustomerName = 'Customer 1';

  // Getters
  int get finalPrice => _finalPrice;
  String get customerName => _customerName;
  String? get bookingError => _bookingError;
  String get defaultCustomerName => _defaultCustomerName;

  BookingProvider() {
    _initializeCustomerName();
  }

  // --- Price Management ---
  void initializePrice(int totalPrice) {
    _finalPrice = totalPrice;
    notifyListeners();
  }

  void setFinalPrice(String priceString) {
    _finalPrice = int.tryParse(priceString) ?? 0;
    _bookingError = null;
    notifyListeners();
  }

  // --- Customer Name Management ---
  void setCustomerName(String name) {
    _customerName = name;
  }

  Future<void> _initializeCustomerName() async {
    final prefs = await SharedPreferences.getInstance();
    final lastResetDateString = prefs.getString(_dateKey);
    final now = DateTime.now();

    if (lastResetDateString != null) {
      final lastResetDate = DateTime.parse(lastResetDateString);
      
      // Simple daily reset check
      if (lastResetDate.year != now.year || 
          lastResetDate.month != now.month || 
          lastResetDate.day != now.day) 
      {
        await _resetCount(prefs, now);
      }
    } else {
      await _resetCount(prefs, now);
    }
    
    final count = prefs.getInt(_customerKey) ?? 1;
    _defaultCustomerName = 'Customer $count';
    notifyListeners();
  }

  Future<void> _resetCount(SharedPreferences prefs, DateTime now) async {
    await prefs.setInt(_customerKey, 1);
    // Store only the date part for a simple daily check
    await prefs.setString(_dateKey, now.toIso8601String().substring(0, 10));
  }

  Future<void> incrementCustomerCount() async {
    final prefs = await SharedPreferences.getInstance();
    final currentCount = prefs.getInt(_customerKey) ?? 1;
    final newCount = currentCount + 1;
    
    await prefs.setInt(_customerKey, newCount);
    _defaultCustomerName = 'Customer $newCount';
    notifyListeners();
  }

  // --- Validation and Booking Logic ---
  bool confirmBooking({
    required int basePrice, 
    required bool hasServices, 
    required int maxDiscountAmount, 
  }) {
    if (!hasServices) {
      _bookingError = 'Please select at least one service.';
      notifyListeners();
      return false;
    }
    
    // Enforce the flexible discount rule
    final int minAcceptablePrice = basePrice - maxDiscountAmount;
    
    if (_finalPrice < minAcceptablePrice) {
      _bookingError = 'Price cannot be reduced by more than $maxDiscountAmount tk (Min: $minAcceptablePrice tk).';
      notifyListeners();
      return false;
    }

    _bookingError = null;
    notifyListeners();
    
    print('Booking Confirmed: $_customerName is paying $_finalPrice tk (Base: $basePrice tk)');
    
    return true;
  }
}