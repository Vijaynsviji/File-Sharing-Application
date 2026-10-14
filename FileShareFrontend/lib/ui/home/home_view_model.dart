import 'package:flutter/material.dart';

import '../../global/models/peer_device.dart';
import 'home_model.dart';
import 'home_service.dart';

class HomeViewModel extends ChangeNotifier {
  late HomeModel homeModel;

  bool isLoading = true;
  bool isError = false;
  String errorData = "";

  HomeViewModel({required this.homeModel}) {
    loadStorageData();
  }

  void loadStorageData() async {
    try {
      final deviceStorageInfo = await getStorageDetails();
      // final newHomeModel = HomeModel(
      //   oldTransferPeers: homeModel.oldTransferPeers,
      //   totalDeviceStorage: deviceStorageInfo.totalSpace,
      //   totalUsedStorage: deviceStorageInfo.usedSpace
      // );

      // homeModel.usedPercentage = deviceStorageInfo.usedPercentage;
      // homeModel.totalDeviceStorage = deviceStorageInfo.totalSpace;
      // homeModel.totalUsedStorage = deviceStorageInfo.usedSpace;

      homeModel = HomeModel(
        // Keep whatever data you need from the old model
        oldTransferPeers: homeModel.oldTransferPeers,

        // Inject the new data
        usedPercentage: deviceStorageInfo.usedPercentage,
        totalDeviceStorage: deviceStorageInfo.totalSpace,
        totalUsedStorage: deviceStorageInfo.usedSpace,
      );
      isLoading = false;
    } catch (e) {
      isError = true;
      errorData = "Not Able to Load Storage Data";
      notifyListeners();
    } finally {
      notifyListeners();
    }
  }

  void updatePeerList(List<PeerDevice> newList) {
    homeModel.oldTransferPeers = newList;
    notifyListeners(); // Alert your sub-widgets (like HomePeerList) to redraw
  }
}
