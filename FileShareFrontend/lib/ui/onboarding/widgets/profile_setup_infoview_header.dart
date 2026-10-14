import 'package:flutter/material.dart';

import '../../../core/Language/l10n_extensions.dart';
import '../../../core/Utils/TextStyles.dart';

class ProfileSetupInfoviewHeader extends StatelessWidget {
  const ProfileSetupInfoviewHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 10,
      children: [
        Text(context.strings.tellUsAboutYou, style: context.styles.header),
        Text(
          context.strings.tellUsAboutYouSubtitle,
          style: context.styles.body,
        ),
      ],
    );
  }
}
