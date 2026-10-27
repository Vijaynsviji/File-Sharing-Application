import 'package:file_share_application_frontend/core/Language/l10n_extensions.dart';
import 'package:file_share_application_frontend/core/Utils/TextStyles.dart';
import 'package:flutter/material.dart';

import '../../../global/models/app_colors.dart';

class WifiDirectGroupNotConnectedCard extends StatelessWidget {
  const WifiDirectGroupNotConnectedCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: context.colors.line),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 10,
        children: [
          Text(
            context.strings.notConnectedTitle,
            style: context.styles.listTitle,
          ),
          Text(context.strings.notConnectedBody, style: context.styles.caption),
        ],
      ),
    );
  }
}
