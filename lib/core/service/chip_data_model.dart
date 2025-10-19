import 'package:flutter/material.dart';

class ChipData {
  final int id; // unique identifier
  final String label; // display text
  final String description; // short description text
  final Color color; // background color
  final double price; // service price

  const ChipData({
    required this.id,
    required this.label,
    required this.description,
    required this.color,
    required this.price,
  });
}

class Chips {
  static final all = <ChipData>[
    ChipData(
      id: 1,
      label: 'Haircut',
      description: 'A stylish haircut to refresh your look.',
      color: Colors.grey,
      price: 300,
    ),
    ChipData(
      id: 2,
      label: 'Shaving',
      description: 'Smooth shaving service for a clean look.',
      color: Colors.grey,
      price: 150,
    ),
    ChipData(
      id: 3,
      label: 'Facial',
      description: 'Rejuvenating facial treatment for glowing skin.',
      color: Colors.grey,
      price: 500,
    ),
    ChipData(
      id: 4,
      label: 'Massage',
      description: 'Relaxing massage to relieve stress and tension.',
      color: Colors.grey,
      price: 700,
    ),
    ChipData(
      id: 5,
      label: 'Hair Coloring',
      description: 'Change your hair color with our professional coloring.',
      color: Colors.grey,
      price: 1000,
    ),
    ChipData(
      id: 6,
      label: 'Beard Trim',
      description: 'Shape and style your beard for a neat appearance.',
      color: Colors.grey,
      price: 200,
    ),
    ChipData(
      id: 7,
      label: 'Scalp Treatment',
      description:
          'Healthy scalp treatment to reduce dandruff and promote growth.',
      color: Colors.grey,
      price: 600,
    ),
    ChipData(
      id: 8,
      label: 'Hot Towel Shave',
      description: 'Luxury hot towel shave for ultimate comfort.',
      color: Colors.grey,
      price: 250,
    ),
    ChipData(
      id: 9,
      label: 'Hair Spa',
      description: 'Nourishing hair spa for soft and healthy hair.',
      color: Colors.grey,
      price: 800,
    ),
    ChipData(
      id: 10,
      label: 'Kids Haircut',
      description: 'Fun and safe haircut experience for kids.',
      color: Colors.grey,
      price: 250,
    ),
  ];
}
