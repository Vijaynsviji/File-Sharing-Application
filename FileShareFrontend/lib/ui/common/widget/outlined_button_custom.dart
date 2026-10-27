import 'package:file_share_application_frontend/core/Language/l10n_extensions.dart';
import 'package:file_share_application_frontend/core/Utils/TextStyles.dart';
import 'package:file_share_application_frontend/global/models/app_colors.dart';
import 'package:flutter/material.dart';

class OutlinedButtonCustom extends StatelessWidget {
  final Color? textColor;
  final String text;
  final Color? borderColor;
  final Color? backgroundColor;
  final void Function()? onPressed;
  final double buttonBorderRadius;
  final double buttonPadding;
  final double borderWidth;
  final double? height;
  final double? width;
  final double? textSize; // 👈 Added optional text size

  const OutlinedButtonCustom({
    super.key,
    this.textColor,
    required this.text,
    required this.onPressed,
    this.borderColor,
    this.backgroundColor,
    this.buttonBorderRadius = 12.0,
    this.buttonPadding = 15,
    this.borderWidth = 1.5,
    this.height,
    this.width,
    this.textSize,
  });

  @override
  Widget build(BuildContext context) {
    final defaultColor = context.colors.indigo;

    return SizedBox(
      height: height,
      width: width,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          backgroundColor: backgroundColor,
          padding: EdgeInsets.all(buttonPadding),
          side: BorderSide(
            color: borderColor ?? defaultColor,
            width: borderWidth,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(buttonBorderRadius),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: context.styles.buttonPrimary.copyWith(
            color: textColor ?? borderColor ?? defaultColor,
            fontSize: textSize, // 👈 Applies specific text size if provided
          ),
        ),
      ),
    );
  }
}
