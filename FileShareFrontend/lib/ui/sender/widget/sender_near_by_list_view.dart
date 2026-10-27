import 'package:file_share_application_frontend/global/Providers/DiscoveryNotifier.dart';
import 'package:file_share_application_frontend/global/models/peer_device.dart';
import 'package:file_share_application_frontend/ui/common/widget/primary_button_custom.dart';
import 'package:file_share_application_frontend/ui/receiver/widget/near_by_list_tile_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../sender_view_model.dart';

// class SenderNearByListView extends StatelessWidget {
//   const SenderNearByListView({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         PrimaryButtonCustom(
//           text: "Start BroadCasting",
//           onPressed: () {
//             context.read<SenderViewModel>().startBroadCasting();
//           },
//         ),
//       ],
//     );
//   }
// }

class SenderNearByListView extends StatefulWidget {
  const SenderNearByListView({super.key});

  @override
  State<SenderNearByListView> createState() => _SenderNearByListViewState();
}

class _SenderNearByListViewState extends State<SenderNearByListView> {
  late SenderViewModel _viewModel;
  late Discoverynotifier _discoveryViwModel;
  @override
  void initState() {
    super.initState();
    // print("Screen Initialized! Setup your controllers or variables here.");
    // context.read<SenderViewModel>().startBroadCasting();
    _viewModel = context.read<SenderViewModel>();
    _discoveryViwModel = context.read<Discoverynotifier>();
    _viewModel.startBroadCasting();
  }

  // 2. DISPOSE: Runs exactly once when the widget leaves the screen permanently
  @override
  void dispose() {
    // print("Screen Destroyed! Clean up your listeners, timers, or controllers here.");
    // context.read<SenderViewModel>().stopBroadCasting();
    _viewModel.stopBroadCasting();
    _discoveryViwModel.resetDiscoveryStates();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final onlineDevices = context.select<Discoverynotifier, List<PeerDevice>>(
      (viewModel) => viewModel.onlinePeerDevices,
    );
    return ListView.builder(
      // 1. Tell Flutter how many items are in the list
      itemCount: onlineDevices.length,

      // 2. Build each individual row item dynamically
      itemBuilder: (context, index) {
        final peerDevice = onlineDevices[index];
        return NearByListTileView(peerDevice: peerDevice);
      },
    );
  }
}
