import 'package:file_share_application_frontend/core/Language/l10n_extensions.dart';
import 'package:flutter/material.dart';

import '../../../core/Utils/TextStyles.dart';

class ProfileSetupViewHeader extends StatelessWidget {
  const ProfileSetupViewHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 10,
        children: [
          Text(context.strings.pickYourAvatar, style: context.styles.header),
          Text(
            context.strings.pickAvatarSubtitle,
            style: context.styles.body,
            softWrap: true,
          ),
        ],
      ),
    );
  }
}
