import 'package:flutter/material.dart';
import 'package:hair_saloon/core/service/chip_data_model.dart';

class ServiceProvider extends ChangeNotifier {
  final List<ChipData> _services = List.from(Chips.all);

  List<ChipData> get services => _services;

  // Edit a service
  void editService(int index, String label, String description, double price) {
    _services[index] = ChipData(
      label: label,
      description: description,
      price: price,
    );
    notifyListeners();
  }

  // Remove a service
  void removeService(int index) {
    _services.removeAt(index);
    notifyListeners();
  }
}
