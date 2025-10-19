import 'package:flutter/material.dart';

class Card1 extends StatelessWidget {
  final VoidCallback onTap;
  final String label;
  final String sublabel;
  final Color color;
  final IconData icon;

  const Card1({
    super.key,
    required this.onTap,
    required this.label,
    required this.sublabel,
    required this.color,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20,),
      child: GestureDetector(
        onTap: onTap,
        child: Material(
          elevation: 3,
          borderRadius: BorderRadius.circular(16),
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [color.withAlpha(230), color.withAlpha(180)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: color.withAlpha(90),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 18.0,
                vertical: 16.0,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Left Section (Texts)
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize
                          .min, // 👈 makes the card height fit the content
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          label,
                          style: const TextStyle(
                            color: Colors.black87,
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.5,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          sublabel,
                          style: TextStyle(
                            color: Colors.black45.withAlpha(230),
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(width: 16),

                  // Right Section (Icon)
                  Container(
                    height: 55,
                    width: 55,
                    decoration: BoxDecoration(
                      color: Colors.white.withAlpha(50),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: Colors.white.withAlpha(100),
                        width: 1.2,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withAlpha(38),
                          blurRadius: 6,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Icon(icon, color: Colors.green, size: 35),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
