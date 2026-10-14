import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

import '../../../global/models/app_colors.dart';

// Note: Make sure your context.colors extension is imported here!

class HugeIconCustom extends StatelessWidget {
  final dynamic icon;
  final double? size;
  final Color? color; // Standard icon color
  final Color? fillColor; // Background color behind the icon
  final Color? outlineColor; // Border color around the background

  const HugeIconCustom({
    super.key,
    required this.icon,
    this.size,
    this.color,
    this.fillColor,
    this.outlineColor,
  });

  @override
  Widget build(BuildContext context) {
    // 1. Define the base icon
    Widget iconWidget = HugeIcon(
      icon: icon,
      // Uses `color`, falls back to your theme's ink color
      color: color ?? context.colors.ink,
      size: size ?? 32.0,
    );

    // 2. If a fillColor or outlineColor is provided, wrap it in a Container
    if (fillColor != null || outlineColor != null) {
      return Container(
        padding: const EdgeInsets.all(
          8.0,
        ), // Space between icon and the background edge
        decoration: BoxDecoration(
          color: fillColor ?? Colors.transparent, // Fill color inside
          shape: BoxShape.circle, // Makes the background circular
          border: outlineColor != null
              ? Border.all(
                  color: outlineColor!,
                  width: 1.5,
                ) // Outline around the background
              : null,
        ),
        child: iconWidget,
      );
    }

    // 3. If no fill or outline is provided, just return the plain icon
    return iconWidget;
  }
}
