import 'package:file_share_application_frontend/core/Language/l10n_extensions.dart';
import 'package:file_share_application_frontend/ui/wifi_direct_groups/widget/near_by_device_empty_list_view.dart';
import 'package:file_share_application_frontend/ui/wifi_direct_groups/widget/near_by_device_list_tile.dart';
import 'package:file_share_application_frontend/ui/wifi_direct_groups/wifi_direct_group_model.dart';
import 'package:file_share_application_frontend/ui/wifi_direct_groups/wifi_direct_group_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:wifi_direct_plugin/wifi_direct_plugin_platform_interface.dart';

import 'near_by_device_list_title.dart';

class NearByDeviceListView extends StatelessWidget {
  const NearByDeviceListView({super.key});

  @override
  Widget build(BuildContext context) {
    final allPeerDevices = context
        .select<WifiDirectGroupViewModel, List<WifiDirectDevice>?>(
          (viewModel) => viewModel.wifiDirectGroupModel?.allNearByPeers,
        );
    final isLoading = context.select<WifiDirectGroupViewModel, bool>(
      (viewModel) => viewModel.isLoading,
    );

    final isRefreshing = context.select<WifiDirectGroupViewModel, bool>(
      (viewModel) => viewModel.isRefreshLoading,
    );

    // if (allPeerDevices == null) {
    //   return ;
    // }

    return Column(
      children: [
        NearByDeviceListTitle(),
        allPeerDevices == null
            ? Skeletonizer(
                enabled: isLoading || isRefreshing,
                child: NearByDeviceEmptyListView(),
              )
            : ListView.builder(
                itemCount: allPeerDevices.length,
                itemBuilder: (context, index) {
                  final device = allPeerDevices[index];
                  return NearByDeviceListTile(device: device);
                },
              ),
      ],
    );
  }
}
