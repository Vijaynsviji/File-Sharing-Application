import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

import '../../../core/Language/l10n_extensions.dart';
import '../../../global/models/app_colors.dart';
import '../../common/widget/primary_button_custom.dart';

class HomeButtonCard extends StatelessWidget {
  final String buttonText;
  final dynamic hugeIconValue;
  final Color cardBackgroundColor;
  final void Function() handleButtonClick;
  final double borderRadiusValue;

  final Color? hugeIconColor;
  final double? hugeIconSize;
  const HomeButtonCard({
    super.key,
    required this.hugeIconValue,
    required this.buttonText,
    required this.handleButtonClick,
    required this.cardBackgroundColor,
    required this.borderRadiusValue,
    this.hugeIconColor,
    this.hugeIconSize,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: cardBackgroundColor,
          borderRadius: BorderRadius.circular(borderRadiusValue),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          spacing: 15,
          children: [
            HugeIcon(
              icon: hugeIconValue,
              color:
                  hugeIconColor ??
                  context.colors.ink, // You can now dynamically theme it!
              size: hugeIconSize ?? 32.0,
            ),
            PrimaryButtonCustom(
              // text: context.strings.send,
              text: buttonText,
              onPressed: handleButtonClick,
              BackgroundColor: context.colors.card,
              textColor: context.colors.ink,
            ),
          ],
        ),
      ),
    );
  }
}
