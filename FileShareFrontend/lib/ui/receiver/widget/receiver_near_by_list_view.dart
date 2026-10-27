import 'package:file_share_application_frontend/ui/common/widget/primary_button_custom.dart';
import 'package:file_share_application_frontend/ui/receiver/receiver_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../global/Providers/DiscoveryNotifier.dart';
import '../../../global/models/peer_device.dart';
import 'near_by_list_tile_view.dart';

// class ReceiverNearByListView extends StatelessWidget {
//   const ReceiverNearByListView({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         PrimaryButtonCustom(
//           text: "Listen Broadcast",
//           onPressed: () {
//             context.read<ReceiverViewModel>().startBroadCastListening();
//           },
//         ),
//       ],
//     );
//   }
// }

class ReceiverNearByListView extends StatefulWidget {
  const ReceiverNearByListView({super.key});

  @override
  State<ReceiverNearByListView> createState() => _ReceiverNearByListViewState();
}

class _ReceiverNearByListViewState extends State<ReceiverNearByListView> {
  late ReceiverViewModel _viewModel;
  late Discoverynotifier _discoveryViwModel;
  @override
  void initState() {
    super.initState();
    // print("Screen Initialized! Setup your controllers or variables here.");
    // context.read<ReceiverViewModel>().startBroadCastListening();
    _viewModel = context.read<ReceiverViewModel>();
    _discoveryViwModel = context.read<Discoverynotifier>();
    _viewModel.startBroadCastListening();
  }

  // 2. DISPOSE: Runs exactly once when the widget leaves the screen permanently
  @override
  void dispose() {
    // print("Screen Destroyed! Clean up your listeners, timers, or controllers here.");
    _viewModel.stopBroadCastListening();
    _discoveryViwModel.resetDiscoveryStates();
    super.dispose();
    // context.read<ReceiverViewModel>().stopBroadCastListening();
  }

  @override
  Widget build(BuildContext context) {
    final onlineDevices = context.select<Discoverynotifier, List<PeerDevice>>(
      (viewModel) => viewModel.onlinePeerDevices,
    );
    // print("Receiver Online Devieces: " + onlineDevices.toString());
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
