import 'package:file_share_application_frontend/core/Utils/TextStyles.dart';
import 'package:flutter/material.dart';

import '../../../global/models/app_colors.dart';

class CustomTextfield extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final bool isMultiLine;
  const CustomTextfield({
    super.key,
    required this.label,
    required this.controller,
    this.isMultiLine = false,
  });

  @override
  Widget build(BuildContext context) {
    final borderStyle = OutlineInputBorder(
      borderRadius: BorderRadius.circular(16.0), // Large smooth rounded corners
      borderSide: BorderSide(
        color:
            context.colors.line ??
            const Color(0xFFFAFBFF), // 🟢 Fixed hex syntax color format
        width: 1.0, // Explicitly declare line thickness
      ),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 10,
      children: [
        Text(label, style: context.styles.label),
        TextField(
          keyboardType: isMultiLine
              ? TextInputType.multiline
              : TextInputType.text,
          maxLines: isMultiLine ? 5 : 1,
          controller: controller,
          style: TextStyle(
            color: context.colors.ink, // Sets input text color (Ananya Rao)
            fontSize: 15.0,
          ),
          decoration: InputDecoration(
            // 1. 🟢 Enables background container fill color
            filled: true,
            fillColor: context.colors.cardAlt2 ?? const Color(0xFFFAFBFF),

            // 2. 🟢 Padding inside the text field bounds to space the text out nicely
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 16.0,
            ),

            // 🟢 1. Universal fallback layout rules
            border: borderStyle,

            // 🟢 2. FIXED: This controls the color when the field is sitting idle on screen
            enabledBorder: borderStyle,

            // 🟢 3. Controls the color when the user selects/taps the text input field
            focusedBorder: borderStyle,
          ),
        ),
      ],
    );
  }
}
