import 'package:file_share_application_frontend/core/Utils/TextStyles.dart';
import 'package:file_share_application_frontend/ui/wifi_direct_groups/wifi_direct_group_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/Language/l10n_extensions.dart';

class NearByDeviceListTitle extends StatelessWidget {
  const NearByDeviceListTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(context.strings.nearbyGroups, style: context.styles.label),
        IconButton(
          onPressed: () {
            context.read<WifiDirectGroupViewModel>().handleRefresh();
          },
          icon: Icon(Icons.refresh),
        ),
      ],
    );
  }
}
