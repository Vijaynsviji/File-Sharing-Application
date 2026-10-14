import 'package:file_share_application_frontend/core/Language/l10n_extensions.dart';
import 'package:file_share_application_frontend/core/Utils/TextStyles.dart';
import 'package:file_share_application_frontend/global/Providers/PeerDeviceNotifier.dart';
import 'package:file_share_application_frontend/global/models/peer_device.dart';
import 'package:file_share_application_frontend/ui/home/widget/home_empty_latest_activity.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeHistoryView extends StatelessWidget {
  const HomeHistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    final peerDevicesList = context
        .select<PeerDeviceNotifier, List<PeerDevice>>(
          (viewModel) => viewModel.peerDevices,
        );

    final isPeerDeviceEmpty = peerDevicesList.isEmpty;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      spacing: 30,
      children: [
        Text(context.strings.latestActivities, style: context.styles.label),
        isPeerDeviceEmpty ? HomeEmptyLatestActivity() : Container(),
      ],
    );
  }
}
