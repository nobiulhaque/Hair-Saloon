import 'package:flutter/material.dart';

class EmployeeCard extends StatelessWidget {
  final String name;
  final String phone;
  final String email;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  const EmployeeCard({
    super.key,
    required this.name,
    required this.phone,
    required this.email,
    this.onEdit,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final primaryGreen = Colors.green.shade700;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: primaryGreen.withOpacity(0.3)),
        boxShadow: [
          BoxShadow(
            color: Colors.green.withOpacity(0.08),
            offset: const Offset(0, 2),
            blurRadius: 5,
          ),
        ],
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            backgroundColor: primaryGreen,
            radius: 25,
            child: Text(
              name.isNotEmpty ? name[0].toUpperCase() : '?',
              style: const TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
          const SizedBox(height: 8),
          Flexible(
            child: Text(
              name,
              textAlign: TextAlign.center,
              maxLines: 2, 
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: primaryGreen,
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            phone,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 13),
          ),
          Text(
            email,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 12, color: Colors.grey),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.edit, color: Colors.green, size: 20),
                onPressed: onEdit,
              ),
              IconButton(
                icon: const Icon(Icons.delete, color: Colors.redAccent, size: 20),
                onPressed: onDelete,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
