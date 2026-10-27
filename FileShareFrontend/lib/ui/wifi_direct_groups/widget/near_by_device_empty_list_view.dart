import 'package:file_share_application_frontend/core/Language/l10n_extensions.dart';
import 'package:file_share_application_frontend/core/Utils/TextStyles.dart';
import 'package:file_share_application_frontend/ui/common/widget/primary_button_custom.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../global/models/app_colors.dart';
import '../wifi_direct_group_view_model.dart';

class NearByDeviceEmptyListView extends StatelessWidget {
  const NearByDeviceEmptyListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: context.colors.line),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: EdgeInsets.all(20),
      child: Column(
        spacing: 20,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text(
              context.strings.noGroupsTitle,
              style: context.styles.subtitle,
            ),
          ),
          Center(
            child: Text(
              context.strings.noGroupsBody,
              style: context.styles.caption,
            ),
          ),
          PrimaryButtonCustom(
            text: context.strings.refresh,
            onPressed: () {
              context.read<WifiDirectGroupViewModel>().handleRefresh();
            },
          ),
        ],
      ),
    );
  }
}
