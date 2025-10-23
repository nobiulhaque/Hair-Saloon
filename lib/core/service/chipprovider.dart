import 'package:flutter/material.dart';
import 'chip_data_model.dart';

class ChipProvider extends ChangeNotifier {
  final List<ChipData> chips = Chips.all;
  final Set<int> selectedChips = {};

  /// Toggle a chip manually (when user taps)
  void toggleChip(int index) {
    if (selectedChips.contains(index)) {
      selectedChips.remove(index);
    } else {
      selectedChips.add(index);
    }
    notifyListeners();
  }

  /// Calculate total price of all selected chips
  double get totalPrice =>
      selectedChips.map((i) => chips[i].price).fold(0.0, (a, b) => a + b);

  /// Clear all current selections
  void clearSelection() {
    selectedChips.clear();
    notifyListeners();
  }

  /// Preselect a chip by its title when booking starts
  void selectChipByTitle(String title) {
    clearSelection(); // reset any previous selection
    for (int i = 0; i < chips.length; i++) {
      if (chips[i].label == title) {
        selectedChips.add(i);
        break;
      }
    }
    notifyListeners();
  }

  void updateTotalPrice(double parsed) {}
}
