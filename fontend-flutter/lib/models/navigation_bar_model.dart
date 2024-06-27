import 'package:flutter/material.dart';

class Button {
  final String name;
  final IconData icon;
  bool isSelected;

  Button({
    required this.name,
    required this.icon,
    this.isSelected = false,
  });
}
