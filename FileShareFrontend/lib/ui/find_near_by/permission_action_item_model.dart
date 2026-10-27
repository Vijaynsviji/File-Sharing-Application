import 'package:flutter/material.dart';

class PermissionActionItem {
  final IconData icon;
  final String text;
  final VoidCallback onPressed;
  final bool isGranted; // Renamed from 'visible' for clarity

  PermissionActionItem({
    required this.icon,
    required this.text,
    required this.onPressed,
    required this.isGranted,
  });
}
