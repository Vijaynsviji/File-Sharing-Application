import 'package:file_share_application_frontend/core/Language/l10n_extensions.dart';
import 'package:file_share_application_frontend/core/Utils/TextStyles.dart';
import 'package:file_share_application_frontend/ui/common/widget/outlined_button_custom.dart';
import 'package:file_share_application_frontend/ui/common/widget/primary_button_custom.dart';
import 'package:file_share_application_frontend/ui/find_near_by/find_near_by_view_model.dart';
import 'package:file_share_application_frontend/ui/receiver/receiver_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../common/widget/icon_avatar.dart';
import '../../find_near_by/find_near_by_generic_settings_view.dart';
import '../../find_near_by/permission_action_item_model.dart';

class ReceiverSettingsView extends StatelessWidget {
  const ReceiverSettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<DevicePermissionViewModel>();

    // List<Map<String, dynamic>> settingsListViewData = [
    //   // {
    //   //   'icon': Icons.bluetooth,
    //   //   'text': 'Bluetooth',
    //   //   'onPressed': () async {
    //   //     await DeviceSettingsUtil.ensureReady(DeviceHardware.bluetooth);
    //   //   },
    //   // },
    //   {
    //     'icon': Icons.location_on,
    //     'text': 'Location',
    //     'onPressed': () async {
    //       context.read<DevicePermissionViewModel>().handleLocationOn();
    //     },
    //     'visible': viewModel.isLocationOn,
    //   },
    //   {
    //     'icon':
    //         Icons.wifi, // Or Icons.wifi_tethering depending on your preference
    //     'text': 'Wifi',
    //     'onPressed': () async {
    //       context.read<DevicePermissionViewModel>().handleWifiOn();
    //     },
    //     'visible': viewModel.isWifiOn,
    //   },
    // ];

    // final visibleSettingsList = settingsListViewData
    //     .where((item) => item['visible'] == false)
    //     .toList();

    return GenericPermissionSettingsView(
      title: "Turn on Settings",
      settingsList: [
        PermissionActionItem(
          icon: Icons.location_on,
          text: 'Location',
          onPressed: () => viewModel.handleLocationOn(),
          isGranted: viewModel.isLocationOn,
        ),
        PermissionActionItem(
          icon: Icons.wifi,
          text: 'Wifi',
          onPressed: () => viewModel.handleWifiOn(),
          isGranted: viewModel.isWifiOn,
        ),
      ],
    );
    // return Column(
    //   crossAxisAlignment: CrossAxisAlignment.stretch,
    //   spacing: 10,
    //   children: [
    //     Text("Turn on Settings", style: context.styles.label),
    //     Expanded(
    //       child: ListView.builder(
    //         itemCount: visibleSettingsList.length,
    //         // shrinkWrap: true,
    //         // physics: const NeverScrollableScrollPhysics(),
    //         itemBuilder: (context, index) {
    //           final item = visibleSettingsList[index];
    //           return ListTile(
    //             leading: IconAvatar(
    //               icon: item['icon'],
    //               isAvatarSelected: false,
    //               height: 30,
    //               width: 30,
    //             ),
    //             title: Text(item['text'], style: context.styles.listTitle),
    //             trailing: OutlinedButtonCustom(
    //               text: context.strings.join,
    //               onPressed: item['onPressed'],
    //               buttonBorderRadius: 30,
    //               buttonPadding: 0,
    //               height: 40,
    //               textSize: 10,
    //             ),
    //           );
    //         },
    //       ),
    //     ),
    //   ],
    // );
  }
}
