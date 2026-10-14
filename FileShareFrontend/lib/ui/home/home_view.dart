import 'package:file_share_application_frontend/global/Providers/PeerDeviceNotifier.dart';
import 'package:file_share_application_frontend/ui/home/home_model.dart';
import 'package:file_share_application_frontend/ui/home/home_view_model.dart';
import 'package:file_share_application_frontend/ui/home/widget/home_button_view.dart';
import 'package:file_share_application_frontend/ui/home/widget/home_history_view.dart';
import 'package:file_share_application_frontend/ui/home/widget/home_peer_list.dart';
import 'package:file_share_application_frontend/ui/home/widget/home_storage_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../global/models/peer_device.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    // final oldPeerList = context.select<PeerDeviceNotifier, List<PeerDevice>>(
    //   (viewModel) => viewModel.peerDevices,
    // );
    // final homeViewModel = HomeViewModel(
    //   homeModel: HomeModel(oldTransferPeers: oldPeerList),
    // );
    return ChangeNotifierProxyProvider<PeerDeviceNotifier, HomeViewModel>(
      create: (context) =>
          HomeViewModel(homeModel: HomeModel(oldTransferPeers: [])),
      update: (context, peerNotifier, homeViewModel) {
        if (homeViewModel != null) {
          homeViewModel.updatePeerList(peerNotifier.peerDevices);
        }
        return homeViewModel!;
      },
      child: SingleChildScrollView(
        child: Column(
          spacing: 20,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            HomeStorageView(),
            HomeButtonView(),
            HomePeerList(),
            HomeHistoryView(),
          ],
        ),
      ),
    );
  }
}
