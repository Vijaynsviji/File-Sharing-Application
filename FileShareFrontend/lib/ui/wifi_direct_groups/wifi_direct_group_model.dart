import 'package:wifi_direct_plugin/wifi_direct_plugin_platform_interface.dart';

class WifiDirectGroupModel {
  final WifiDirectDevice currentSelectedGroup;
  final List<WifiDirectDevice> allNearByPeers;

  WifiDirectGroupModel({
    required this.allNearByPeers,
    required this.currentSelectedGroup,
  });

  // Creates a copy of this object with the given fields replaced by new values
  WifiDirectGroupModel copyWith({
    WifiDirectDevice? currentSelectedGroup,
    List<WifiDirectDevice>? allNearByPeers,
  }) {
    return WifiDirectGroupModel(
      allNearByPeers: allNearByPeers ?? this.allNearByPeers,
      currentSelectedGroup: currentSelectedGroup ?? this.currentSelectedGroup,
    );
  }

  // Optional but recommended: Overriding toString for easier debugging logs
  @override
  String toString() {
    return 'WifiDirectGroupModel(currentSelectedGroup: ${currentSelectedGroup.deviceName}, allNearByPeersCount: ${allNearByPeers.length})';
  }
}
