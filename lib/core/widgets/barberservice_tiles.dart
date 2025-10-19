import 'package:flutter/material.dart';
import 'package:hair_saloon/core/service/chip_data_model.dart';
import 'package:hair_saloon/core/service/chipprovider.dart';
import 'package:hair_saloon/core/widgets/booking_page.dart';
import 'package:provider/provider.dart';

class BarberServiceList extends StatelessWidget {
  const BarberServiceList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Our Services'),
        backgroundColor: Colors.green,
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: Chips.all.length,
        itemBuilder: (context, index) {
          final chip = Chips.all[index];
          return BarberServiceTile(
            title: chip.label,
            description: chip.description,
            price: chip.price.toInt(),
          );
        },
      ),
    );
  }
}

class BarberServiceTile extends StatefulWidget {
  final String title;
  final String description;
  final int price;

  const BarberServiceTile({
    super.key,
    required this.title,
    required this.description,
    required this.price,
  });

  @override
  State<BarberServiceTile> createState() => _BarberServiceTileState();
}

class _BarberServiceTileState extends State<BarberServiceTile> {
  void _navigateToBookingPage(BuildContext context) {
    final chipProvider = Provider.of<ChipProvider>(context, listen: false);

    // Preselect this service
    chipProvider.selectChipByTitle(widget.title);

    // Navigate to booking page
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            BookingPage(title: widget.title, price: widget.price),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(right: 18.0, left: 18.0, top: 6.0,),
        child: Card(
          color: Colors.grey[100],
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(Icons.cut, color: Colors.green, size: 28),
                const SizedBox(width: 10),
                // Text content
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              widget.title,
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 15,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(width: 6),
                          Text(
                            '${widget.price} tk',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 13,
                              color: Colors.grey[700],
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        widget.description.isNotEmpty
                            ? widget.description
                            : 'No description available',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 13.5,
                          height: 1.3,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 20),

                // Book button
                ElevatedButton(
                  onPressed: () => _navigateToBookingPage(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 10,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Book',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
