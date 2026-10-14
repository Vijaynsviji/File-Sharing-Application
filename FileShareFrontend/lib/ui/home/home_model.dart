import 'package:file_share_application_frontend/global/models/peer_device.dart';

class HomeModel {
  List<PeerDevice> oldTransferPeers;
  String totalDeviceStorage;
  String totalUsedStorage;
  double usedPercentage;

  HomeModel({
    required this.oldTransferPeers,
    this.totalDeviceStorage = "0 GB",
    this.totalUsedStorage = "0 GB",
    this.usedPercentage = 0,
  });
}
