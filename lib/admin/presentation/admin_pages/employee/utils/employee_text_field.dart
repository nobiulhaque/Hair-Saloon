import 'package:flutter/material.dart';

class AddEmployeeTextField extends StatelessWidget {
  final String label;
  final String hint;
  final IconData icon;
  final TextInputType inputType;
  final TextEditingController? controller;

  const AddEmployeeTextField({
    super.key,
    required this.label,
    required this.hint,
    required this.icon,
    this.inputType = TextInputType.text,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final primaryGreen = Colors.green.shade700;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          keyboardType: inputType,
          decoration: InputDecoration(
            hintText: hint,
            filled: true,
            fillColor: Colors.white,
            prefixIcon: Icon(icon, color: Colors.green),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: primaryGreen),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: primaryGreen, width: 2),
            ),
          ),
        ),
      ],
    );
  }
}
