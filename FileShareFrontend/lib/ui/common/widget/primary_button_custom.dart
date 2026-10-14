import 'package:file_share_application_frontend/core/Language/l10n_extensions.dart';
import 'package:file_share_application_frontend/core/Utils/TextStyles.dart';
import 'package:file_share_application_frontend/global/models/app_colors.dart';
import 'package:flutter/material.dart';

class PrimaryButtonCustom extends StatelessWidget {
  final Color? textColor;
  final String text;
  final Color? BackgroundColor;
  final void Function()? onPressed;
  final double buttonBorderRadius;
  final double buttonPadding;

  const PrimaryButtonCustom({
    super.key,
    this.textColor,
    required this.text,
    required this.onPressed,
    this.BackgroundColor,
    this.buttonBorderRadius = 12.0,
    this.buttonPadding = 15,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: BackgroundColor ?? context.colors.indigo,
        padding: EdgeInsets.all(buttonPadding),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            buttonBorderRadius,
          ), // 👈 Change 12.0 to whatever radius you want
        ),
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: context.styles.buttonPrimary.copyWith(color: textColor),
      ),
    );
  }
}
