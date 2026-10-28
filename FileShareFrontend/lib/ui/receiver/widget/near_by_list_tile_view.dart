import 'package:file_share_application_frontend/core/Language/l10n_extensions.dart';
import 'package:file_share_application_frontend/core/Utils/TextStyles.dart';
import 'package:file_share_application_frontend/global/Providers/DiscoveryNotifier.dart';
import 'package:file_share_application_frontend/global/models/peer_device.dart';
import 'package:file_share_application_frontend/ui/common/widget/initial_avatar.dart';
import 'package:file_share_application_frontend/ui/common/widget/outlined_button_custom.dart';
import 'package:file_share_application_frontend/ui/receiver/receiver_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NearByListTileView extends StatelessWidget {
  final PeerDevice peerDevice;
  const NearByListTileView({super.key, required this.peerDevice});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: InitialAvatar(name: peerDevice.name, isAvatarSelected: false),
      title: Text(peerDevice.name, style: context.styles.listTitle),
      subtitle: Text(peerDevice.deviceName, style: context.styles.subtitle),
      trailing: OutlinedButtonCustom(
        text: context.strings.send,
        onPressed: () {
          final viewModel = context.read<Discoverynotifier>();
          final deviceIPAddress = viewModel.getIPFromDeviceId(
            peerDevice.deviceUniqueId,
          );
          if (deviceIPAddress == null) return;
          print("Device IP Address" + deviceIPAddress);
          context.read<ReceiverViewModel>().sendFileRequest(deviceIPAddress);
        },
      ),
    );
  }
}
