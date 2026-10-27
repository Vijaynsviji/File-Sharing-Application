import 'package:file_share_application_frontend/core/Language/l10n_extensions.dart';
import 'package:file_share_application_frontend/core/Utils/TextStyles.dart';
import 'package:flutter/material.dart';

class ReceiverHeaderView extends StatelessWidget {
  const ReceiverHeaderView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 10,
      children: [
        Text(context.strings.findingPeopleNearby, style: context.styles.header),
        Text(
          context.strings.findingPeopleNearbySubtitle,
          style: context.styles.subtitle,
        ),
      ],
    );
  }
}
