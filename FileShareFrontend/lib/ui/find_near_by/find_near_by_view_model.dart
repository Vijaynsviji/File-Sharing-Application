import 'package:file_share_application_frontend/core/Utils/device_settings_util.dart';
import 'package:flutter/material.dart';

class DevicePermissionViewModel extends ChangeNotifier
    with WidgetsBindingObserver {
  bool _isWifiOn = false;
  bool _isLocationOn = false;

  bool _isLoading = false;
  bool _isError = false;
  String _errorData = "";

  DevicePermissionViewModel() {
    WidgetsBinding.instance.addObserver(this);
    initialLoad();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      initialLoad();
    }
  }

  String get errorData => _errorData;
  bool get isError => _isError;
  bool get isLoading => _isLoading;
  bool get isLocationOn => _isLocationOn;
  bool get isWifiOn => _isWifiOn;
  bool get isBothPermissionGiven => _isWifiOn && _isLocationOn;

  Future<void> initialLoad() async {
    try {
      _isLocationOn = await DeviceSettingsUtil.isSettingEnabled(
        DeviceHardware.location,
      );
      _isWifiOn = await DeviceSettingsUtil.isSettingEnabled(
        DeviceHardware.wifi,
      );
      notifyListeners();
    } catch (e) {
      debugPrint("💡 Error in initialLoad: $e");
      _isError = true;
      _errorData = e.toString();
      notifyListeners();
    }
  }

  Future<void> handleWifiOn() async {
    _isWifiOn = await DeviceSettingsUtil.ensureReady(DeviceHardware.wifi);
    notifyListeners();
  }

  Future<void> handleLocationOn() async {
    _isLocationOn = await DeviceSettingsUtil.ensureReady(
      DeviceHardware.location,
    );
    notifyListeners();
  }
}
