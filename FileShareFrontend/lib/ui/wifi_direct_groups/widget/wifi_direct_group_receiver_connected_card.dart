import 'package:file_share_application_frontend/core/Language/l10n_extensions.dart';
import 'package:file_share_application_frontend/core/Utils/TextStyles.dart';
import 'package:file_share_application_frontend/ui/common/widget/initial_avatar.dart';
import 'package:file_share_application_frontend/ui/wifi_direct_groups/widget/wifi_direct_group_not_connected_card.dart';
import 'package:file_share_application_frontend/ui/wifi_direct_groups/wifi_direct_group_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:wifi_direct_plugin/wifi_direct_plugin_platform_interface.dart';

class WifiDirectGroupReceiverConnectedCard extends StatelessWidget {
  const WifiDirectGroupReceiverConnectedCard({super.key});

  @override
  Widget build(BuildContext context) {
    final isLoading = context.select<WifiDirectGroupViewModel, bool>(
      (viewModel) => viewModel.isLoading,
    );
    final currentJoinedGroup = context
        .select<WifiDirectGroupViewModel, WifiDirectDevice?>(
          (viewModel) => viewModel.wifiDirectGroupModel?.currentSelectedGroup,
        );
    final groupName = currentJoinedGroup?.deviceName;

    if (currentJoinedGroup == null) {
      return Skeletonizer(
        enabled: isLoading,
        child: WifiDirectGroupNotConnectedCard(),
      );
    }

    return Skeletonizer(
      enabled: isLoading,
      child: Container(
        child: Column(
          children: [
            Text(context.strings.connectedTo, style: context.styles.micro),
            Row(
              children: [
                InitialAvatar(
                  name: groupName ?? "Name",
                  isAvatarSelected: false,
                ),
                Text(
                  groupName ?? "Device Name",
                  style: context.styles.secondaryHeader,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
