import 'package:flutter/cupertino.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:wifi_direct_plugin/wifi_direct_plugin.dart';

import 'package:file_share_application_frontend/ui/wifi_direct_groups/wifi_direct_group_model.dart';
import '../../core/Utils/device_settings_util.dart';
import '../../core/notifications/notification_service.dart';

class WifiDirectGroupViewModel extends ChangeNotifier {
  WifiDirectGroupModel? _wifiDirectGroupModel;

  bool _isAllPermissionAccepted = false;
  bool _isLoading = false; // Default to false until a specific action is called
  bool _isRefreshLoading = false;
  bool _isError = false;
  String _errorData = "";

  WifiDirectGroupModel? get wifiDirectGroupModel => _wifiDirectGroupModel;
  bool get isAllPermissionAccepted => _isAllPermissionAccepted;
  bool get isLoading => _isLoading;
  bool get isError => _isError;
  String get errorData => _errorData;
  bool get isRefreshLoading => _isRefreshLoading;

  WifiDirectGroupViewModel() {
    initializeP2P();
  }

  Future<void> initializeP2P() async {
    try {
      await WifiDirectPlugin.initialize();

      // Global listener for discovered peers (Used only by the Receiver screen)
      WifiDirectPlugin.peersStream.listen((peers) {
        if (peers.isNotEmpty) {
          _wifiDirectGroupModel = _wifiDirectGroupModel?.copyWith(
            currentSelectedGroup: peers[0],
            allNearByPeers: peers,
          );

          _isLoading = false;
          _isRefreshLoading = false;
          notifyListeners();
        }
      });
    } catch (e) {
      _isError = true;
      _errorData = e.toString();
      notifyListeners();
    }
  }

  Future<void> _checkAndRequestPermissions() async {
    // 1. Check Location (Software permission + Physical GPS Hardware toggle)
    bool isLocationReady = await DeviceSettingsUtil.ensureReady(
      DeviceHardware.location,
    );
    if (!isLocationReady) {
      // Throwing stops the execution flow so the scanner doesn't start
      throw Exception('Location not ready');
    }

    // 2. Check Nearby Devices (Android 12+ software permission)
    bool isNearbyReady = await DeviceSettingsUtil.ensureReady(
      DeviceHardware.nearbyDevices,
    );
    if (!isNearbyReady) {
      throw Exception('Nearby Devices not ready');
    }

    // 3. If both pass, everything is ready
    _isAllPermissionAccepted = true;
  }

  // ==========================================
  // RECEIVER FUNCTIONS (Client)
  // ==========================================

  // Called when the Receiver pulls to refresh the list of devices
  Future<void> handleRefresh() async {
    _isRefreshLoading = true;
    notifyListeners();
    await startScanningAsClient();
  }

  // Called when entering the Receiver screen
  Future<void> startScanningAsClient() async {
    try {
      _isLoading = true;
      notifyListeners();

      await _checkAndRequestPermissions();

      await WifiDirectPlugin.startAsClient(deviceName: 'FileShareClient');
      await WifiDirectPlugin.startDiscovery();

      Future.delayed(const Duration(seconds: 10), () {
        if (_isLoading || _isRefreshLoading) {
          _isLoading = false;
          _isRefreshLoading = false;
          NotificationService.showErrorDialog(
            'Not able to find nearby devices!',
          );
          notifyListeners();
        }
      });
    } catch (e) {
      _isLoading = false;
      _isRefreshLoading = false;
      NotificationService.showErrorDialog('Permissions required to scan.');
      notifyListeners();
    }
  }

  void handleSelectedNearByPeer(dynamic peer) {
    if (_wifiDirectGroupModel == null) return;
    _wifiDirectGroupModel = _wifiDirectGroupModel?.copyWith(
      currentSelectedGroup: peer,
    );
    notifyListeners();
  }

  // Called when the user taps on a specific peer in the Receiver list
  Future<void> connectToDevice(String deviceAddress) async {
    try {
      _isLoading = true;
      notifyListeners();

      await WifiDirectPlugin.connect(deviceAddress);

      _isLoading = false;
      NotificationService.showSuccessDialog('Connection request sent!');
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      NotificationService.showErrorDialog('Failed to connect to device.');
      notifyListeners();
    }
  }

  // ==========================================
  // SENDER FUNCTIONS (Host)
  // ==========================================

  // Called when entering the Sender screen
  Future<void> startServerGroup() async {
    try {
      _isLoading = true;
      notifyListeners();

      await _checkAndRequestPermissions();

      await WifiDirectPlugin.startAsServer();
      await WifiDirectPlugin.startDiscovery();

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      NotificationService.showErrorDialog(
        'Failed to create group. Check permissions.',
      );
      notifyListeners();
    }
  }
}
