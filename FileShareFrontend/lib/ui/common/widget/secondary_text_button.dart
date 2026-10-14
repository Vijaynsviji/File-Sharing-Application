import 'package:file_share_application_frontend/core/Language/l10n_extensions.dart';
import 'package:file_share_application_frontend/core/Utils/TextStyles.dart';
import 'package:file_share_application_frontend/global/models/app_colors.dart';
import 'package:flutter/material.dart';

class SecondaryTextButton extends StatelessWidget {
  final Color? textColor; // Made nullable to allow dynamic theme fallbacks
  final String text;
  final void Function()? onPressed;

  const SecondaryTextButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.textColor, // Defaults to null; handles fallback in build method
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        // TextButtons don't use a background color, we style the foreground text ink instead
        foregroundColor: textColor ?? context.colors.sub,
      ),
      onPressed: onPressed,
      child: Text(text, style: context.styles.buttonSecondary),
    );
  }
}
