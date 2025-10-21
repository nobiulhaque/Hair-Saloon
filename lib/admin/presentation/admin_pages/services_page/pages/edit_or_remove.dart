import 'package:flutter/material.dart';
import 'package:hair_saloon/admin/presentation/admin_pages/services_page/pages/editor_delete_card.dart';
import 'package:hair_saloon/admin/presentation/admin_pages/services_page/provider/service_provider.dart';
import 'package:provider/provider.dart';
import 'package:hair_saloon/core/service/chip_data_model.dart';
import 'package:hair_saloon/core/utils/custom_textfield.dart';

class EditOrRemove extends StatelessWidget {
  const EditOrRemove({super.key});

  // 🔧 Show edit dialog
  void _showEditDialog(BuildContext context, int index, ChipData service) {
    final nameController = TextEditingController(text: service.label);
    final descController = TextEditingController(text: service.description);
    final priceController = TextEditingController(text: service.price.toString());

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Edit Service'),
        content: SingleChildScrollView(
          child: Column(
            children: [
              CustomTextField(
                controller: nameController,
                label: 'Service',
                icon: Icons.design_services_rounded,
              ),
              const SizedBox(height: 12),
              CustomTextField(
                controller: descController,
                maxLines: 2,
                label: 'Description',
                icon: Icons.description_rounded,
              ),
              const SizedBox(height: 12),
              CustomTextField(
                controller: priceController,
                keyboardType: TextInputType.number,
                label: 'Price',
                icon: Icons.attach_money_rounded,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () {
              // ✅ Update via provider
              Provider.of<ServiceProvider>(context, listen: false).editService(
                index,
                nameController.text,
                descController.text,
                double.tryParse(priceController.text) ?? service.price,
              );
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  // ❌ Show remove confirmation
  void _showDeleteDialog(BuildContext context, int index, String label) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Remove Service'),
        content: Text('Are you sure you want to remove "$label"?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          TextButton(
            onPressed: () {
              Provider.of<ServiceProvider>(context, listen: false).removeService(index);
              Navigator.pop(context);
            },
            child: const Text('Remove', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final services = Provider.of<ServiceProvider>(context).services;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF4CAF50), Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 🔙 Back Button + Title
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () => Navigator.pop(context),
                    ),
                    const SizedBox(width: 4),
                    const Text(
                      'Edit or Remove Services',
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // 🧾 Service list
                Expanded(
                  child: ListView.builder(
                    itemCount: services.length,
                    itemBuilder: (context, index) {
                      final service = services[index];
                      return EditorDeleteCard(
                        service: service,
                        onEdit: () => _showEditDialog(context, index, service),
                        onDelete: () => _showDeleteDialog(context, index, service.label),
                      );
                    },
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
