// booking_page.dart
import 'package:flutter/material.dart';
import 'package:hair_saloon/core/service/booking_provider.dart';
import 'package:hair_saloon/core/service/chipprovider.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class BookingPage extends StatefulWidget {
  const BookingPage({super.key, required String title, required int price});

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  late TextEditingController _customerNameController;
  final TextEditingController _numderController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _customerNameController = TextEditingController();

    // Initialize prices in the booking provider after the first frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final chipProvider = Provider.of<ChipProvider>(context, listen: false);
      final bookingProvider = Provider.of<BookingProvider>(
        context,
        listen: false,
      );

      bookingProvider.initializePrice(chipProvider.totalPrice.toInt());
    });
  }

  @override
  void dispose() {
    _customerNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final chipProvider = context.watch<ChipProvider>();
    final bookingProvider = context.watch<BookingProvider>();

    final priceString = bookingProvider.finalPrice.toString();

    // Set default name if the customer hasn't started typing
    if (_customerNameController.text.isEmpty) {
      _customerNameController.text = bookingProvider.defaultCustomerName;
      bookingProvider.setCustomerName(bookingProvider.defaultCustomerName);
    }

    // Auto Date and Time Logic
    final now = DateTime.now();
    final formattedDate = DateFormat('EEEE, MMM d, y').format(now);
    final formattedTime = DateFormat('h:mm a').format(now);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Booking Page'),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Date and Time (Non-Editable)
            Text(
              'Booking Date & Time',
              style: TextStyle(fontSize: 14, color: Colors.grey[700]),
            ),
            const SizedBox(height: 4),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(12),
              ),
              width: double.infinity,
              child: Text(
                '$formattedDate at $formattedTime',
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Customer Name
            Text(
              'Customer Name',
              style: TextStyle(fontSize: 14, color: Colors.grey[700]),
            ),
            const SizedBox(height: 4),
            TextField(
              controller: _customerNameController,
              onChanged: (name) {
                bookingProvider.setCustomerName(name);
              },
              style: const TextStyle(fontSize: 18, color: Colors.black87),
              decoration: InputDecoration(
                hintText: 'Enter customer name',
                hintStyle: TextStyle(color: Colors.grey[500], fontSize: 16),
                filled: true,
                fillColor: Colors.grey.shade300,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Customer Number
            Text(
              'Phone Number',
              style: TextStyle(fontSize: 14, color: Colors.grey[700]),
            ),
            const SizedBox(height: 4),
            TextField(
              controller: _numderController,
              // onChanged: (name) {
              //   bookingProvider.setCustomerName(name);
              // },
              style: const TextStyle(fontSize: 18, color: Colors.black87),
              decoration: InputDecoration(
                hintText: 'Enter customer phone number',
                hintStyle: TextStyle(color: Colors.grey[500], fontSize: 16),
                filled: true,
                fillColor: Colors.grey.shade300,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Chips
            Wrap(
              spacing: 8,
              runSpacing: 4,
              children: List.generate(chipProvider.chips.length, (index) {
                final chip = chipProvider.chips[index];
                final isSelected = chipProvider.selectedChips.contains(index);
                return Material(
                  type: MaterialType.transparency,
                  child: GestureDetector(
                    onTap: () {
                      chipProvider.toggleChip(index);
                      // Update price in BookingProvider
                      bookingProvider.initializePrice(
                        chipProvider.totalPrice.toInt(),
                      );
                      print(
                        'Selected services total price: ${chipProvider.totalPrice} BDT',
                      );
                    },
                    child: Chip(
                      label: Text(
                        '${chip.label}(${chip.price} BDT)',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      backgroundColor: isSelected ? Colors.green : chip.color,
                      side: BorderSide.none,
                    ),
                  ),
                );
              }),
            ),
            const SizedBox(height: 16),

            // Service Summary
            Text(
              'Service Selected',
              style: TextStyle(fontSize: 14, color: Colors.grey[700]),
            ),
            const SizedBox(height: 4),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(12),
              ),
              width: double.infinity,
              child: Text(
                chipProvider.selectedChips.isNotEmpty
                    ? chipProvider.selectedChips
                          .map((i) => chipProvider.chips[i].label)
                          .join(' + ')
                    : 'No service selected',
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                  height: 1.4,
                ),
              ),
            ),
            const SizedBox(height: 8),

            // Editable Price Field
            Text(
              'Final Price (Editable)',
              style: TextStyle(fontSize: 14, color: Colors.grey[700]),
            ),
            const SizedBox(height: 4),
            TextField(
              key: Key(
                priceString,
              ), // Forces rebuild to reflect provider's value
              controller: TextEditingController(text: priceString),
              keyboardType: TextInputType.number,
              style: const TextStyle(fontSize: 18, color: Colors.black87),
              decoration: InputDecoration(
                hintText: 'Enter final price',
                hintStyle: TextStyle(color: Colors.grey[500], fontSize: 16),
                suffixText: 'tk',
                suffixStyle: const TextStyle(
                  fontSize: 18,
                  color: Colors.black87,
                ),
                filled: true,
                fillColor: Colors.grey.shade300,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                errorText: bookingProvider.bookingError,
              ),
              onChanged: bookingProvider.setFinalPrice,
            ),

            const SizedBox(height: 24),

            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.grey),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Cancel',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    // Inside your ElevatedButton onPressed:
                    onPressed: () async {
                      final basePrice = chipProvider.totalPrice.toInt();
                      final hasServices = chipProvider.selectedChips.isNotEmpty;
                      const int allowedDiscount =
                          150; // Set your flexible discount amount here

                      final bool success = bookingProvider.confirmBooking(
                        basePrice: basePrice,
                        hasServices: hasServices,
                        maxDiscountAmount: allowedDiscount,
                      );

                      // Add a print statement to clearly see the result
                      print('Booking confirmation result: $success');

                      if (success) {
                        // This runs ONLY if success is true
                        await bookingProvider.incrementCustomerCount();
                        _customerNameController.clear();
                        Navigator.pop(context);
                      } else {
                        // This runs if validation failed
                        print(
                          'Booking failed. Check TextField for error message.',
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 0,
                    ),
                    child: const Text(
                      'Confirm Booking',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
