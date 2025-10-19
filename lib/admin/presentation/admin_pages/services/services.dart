import 'package:flutter/material.dart';
import 'package:hair_saloon/core/service/chip_data_model.dart';
import 'package:hair_saloon/core/utils/custom_textfield.dart';
import 'package:hair_saloon/core/widgets/barberservice_tiles.dart';
import 'package:hair_saloon/core/widgets/card1.dart';

class Services extends StatelessWidget {
  const Services({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.green, // Top gradient color
              Colors.white, // Bottom gradient color
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              /// Top Card: Add Services
              Card1(
                onTap: () => addServiceDialog(context),
                icon: Icons.design_services_rounded,
                label: 'Add Services',
                sublabel: 'Total Services: ${Chips.all.length}',
                color: Colors.grey.shade200,
              ),
              SizedBox(height:10),
              //Edit and Remove Services Card
              Card1(
                onTap: () {
                  // Navigate to edit/remove services page
                },
                icon: Icons.edit_rounded,
                label: 'Edit or Remove Services',
                sublabel: 'Manage existing services',
                color: Colors.grey.shade200,
              ),

              const SizedBox(height: 10),
              /// Divider Bar
              Material(
                elevation: 2,
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  height: 5,
                  width: 300,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 5),

              /// Services List (dynamic from Chips.all)
              Expanded(
                child: ShaderMask(
                  shaderCallback: (Rect bounds) {
                    return const LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: <Color>[
                        Colors.transparent,
                        Colors.black,
                        Colors.black,
                        Colors
                            .transparent,
                      ],
                      stops: [0.0, 0.02, 0.97, 1.0],
                    ).createShader(bounds);
                  },
                  blendMode: BlendMode.dstIn,
                  // The ListView.builder is the content to be masked
                  child: ListView.builder(
                    itemCount: Chips.all.length,
                    itemBuilder: (context, index) {
                      final chip = Chips.all[index];
                      return GestureDetector(
                        onTap: () {
                          // Edit service card tap action
                        },
                        child: BarberServiceTile(
                          title: chip.label,
                          description: chip.description.isNotEmpty
                              ? chip.description
                              : 'No description available',
                          price: chip.price.toInt(),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Dialog to add a new service
  Future<void> addServiceDialog(BuildContext context) => showDialog(
    context: context,
    builder: (context) => Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      insetPadding: const EdgeInsets.symmetric(horizontal: 20),
      child: FractionallySizedBox(
        widthFactor: 0.9, // 90% of screen width
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Add New Service',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),

                // Input Fields
                const CustomTextField(
                  label: 'Service Name',
                  icon: Icons.design_services_rounded,
                ),
                const CustomTextField(
                  label: 'Description',
                  icon: Icons.description_rounded,
                ),
                const CustomTextField(
                  label: 'Price',
                  icon: Icons.attach_money_rounded,
                  keyboardType: TextInputType.number,
                ),

                const SizedBox(height: 24),

                // Actions
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text(
                        'Cancel',
                        style: TextStyle(color: Colors.grey, fontSize: 16),
                      ),
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton.icon(
                      onPressed: () {
                        // Save action logic here
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(Icons.save_rounded),
                      label: const Text('Save'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green.shade700,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 12,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
