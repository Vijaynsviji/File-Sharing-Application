import 'package:file_share_application_frontend/ui/wifi_direct_groups/widget/near_by_device_list_view.dart';
import 'package:file_share_application_frontend/ui/wifi_direct_groups/widget/wifi_direct_group_not_connected_card.dart';
import 'package:flutter/material.dart';

class WifiDirectGroupReceiverManageView extends StatelessWidget {
  const WifiDirectGroupReceiverManageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 30,
      children: [WifiDirectGroupNotConnectedCard(), NearByDeviceListView()],
    );
  }
}
