import 'package:file_share_application_frontend/core/Language/l10n_extensions.dart';
import 'package:file_share_application_frontend/ui/common/widget/initial_avatar.dart';
import 'package:file_share_application_frontend/ui/common/widget/primary_button_custom.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:wifi_direct_plugin/wifi_direct_plugin_platform_interface.dart';

import '../../../core/Utils/TextStyles.dart';
import '../wifi_direct_group_view_model.dart';

class NearByDeviceListTile extends StatelessWidget {
  final WifiDirectDevice device;
  const NearByDeviceListTile({super.key, required this.device});

  @override
  Widget build(BuildContext context) {
    final isLoading = context.select<WifiDirectGroupViewModel, bool>(
      (viewModel) => viewModel.isLoading,
    );

    final isRefreshing = context.select<WifiDirectGroupViewModel, bool>(
      (viewModel) => viewModel.isRefreshLoading,
    );
    return Skeletonizer(
      enabled: isLoading || isRefreshing,
      child: ListTile(
        leading: InitialAvatar(
          name: device.deviceName ?? "",
          isAvatarSelected: false,
          isLoading: isLoading || isRefreshing,
        ),
        title: Text(device.deviceName ?? "", style: context.styles.listTitle),
        // subtitle: Text(device.),
        trailing: PrimaryButtonCustom(
          text: context.strings.join,
          onPressed: () {},
        ),
      ),
    );
  }
}
