import 'package:app_settings/app_settings.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../native_bridge/wifi_bridge.dart';
import '../notifications/notification_service.dart';

enum DeviceHardware {
  location,
  bluetooth,
  wifi,
  nearbyDevices,
  photos,
  videos,
  audio,
  manageExternalStorage, // <-- Added here
}

class DeviceSettingsUtil {
  /// Silently checks if a setting or hardware feature is enabled
  static Future<bool> isSettingEnabled(DeviceHardware hardware) async {
    switch (hardware) {
      case DeviceHardware.location:
        // Checks both the software permission and the physical GPS toggle
        final isGranted = await Permission.location.isGranted;
        final isOn = await Permission.location.serviceStatus.isEnabled;
        return isGranted && isOn;

      case DeviceHardware.bluetooth:
        // Only checks the software permission (cannot check physical radio without flutter_blue_plus)
        return await Permission.bluetoothConnect.isGranted;

      case DeviceHardware.nearbyDevices:
        // Purely an Android 12+ software permission
        return await Permission.nearbyWifiDevices.isGranted;

      case DeviceHardware.wifi:
        return await WifiBridge.isWifiEnabled();

      case DeviceHardware.photos:
        return await Permission.photos.isGranted;

      case DeviceHardware.videos:
        return await Permission.videos.isGranted;

      case DeviceHardware.audio:
        return await Permission.audio.isGranted;

      case DeviceHardware.manageExternalStorage: // <-- Added here
        return await Permission.manageExternalStorage.isGranted;
    }
  }

  /// Checks permission and hardware status for a specific setting or a list of settings.
  /// Accepts either a single [DeviceHardware] or a [List<DeviceHardware>].
  /// Returns [true] if everything is ready to use, [false] if the user needs to take action.
  static Future<bool> ensureReady(dynamic hardwareInput) async {
    if (hardwareInput is List<DeviceHardware>) {
      for (final hardware in hardwareInput) {
        final ready = await _ensureSingleReady(hardware);
        if (!ready) return false; // Stop early if any check fails
      }
      return true;
    } else if (hardwareInput is DeviceHardware) {
      return await _ensureSingleReady(hardwareInput);
    }
    return false;
  }

  /// Internal helper that contains the original switch logic for a single hardware item
  static Future<bool> _ensureSingleReady(DeviceHardware hardware) async {
    switch (hardware) {
      case DeviceHardware.location:
        return await _verifyPermissionAndService(
          permission: Permission.location,
          hardwareName: 'Location',
          settingsType: AppSettingsType.location,
          checkHardwareService: true, // Location CAN be checked physically
        );

      case DeviceHardware.bluetooth:
        return await _verifyPermissionAndService(
          // Use bluetoothConnect for modern Android versions
          permission: Permission.bluetoothConnect,
          hardwareName: 'Bluetooth',
          settingsType: AppSettingsType.bluetooth,
          checkHardwareService:
              false, // CANNOT check physically without flutter_blue_plus
        );

      case DeviceHardware.nearbyDevices:
        // Nearby Devices is purely an Android 12+ software permission
        return await _verifyPermissionAndService(
          permission: Permission.nearbyWifiDevices,
          hardwareName: 'Nearby Devices',
          settingsType: AppSettingsType.settings,
          checkHardwareService: false,
        );

      case DeviceHardware.photos:
        return await _verifyPermissionAndService(
          permission: Permission.photos,
          hardwareName: 'Photos',
          settingsType: AppSettingsType.settings,
          checkHardwareService: false,
        );

      case DeviceHardware.videos:
        return await _verifyPermissionAndService(
          permission: Permission.videos,
          hardwareName: 'Videos',
          settingsType: AppSettingsType.settings,
          checkHardwareService: false,
        );

      case DeviceHardware.audio:
        return await _verifyPermissionAndService(
          permission: Permission.audio,
          hardwareName: 'Audio',
          settingsType: AppSettingsType.settings,
          checkHardwareService: false,
        );

      case DeviceHardware.manageExternalStorage: // <-- Added here
        return await _verifyPermissionAndService(
          permission: Permission.manageExternalStorage,
          hardwareName: 'All Files Access',
          settingsType: AppSettingsType.settings,
          checkHardwareService: false,
        );

      case DeviceHardware.wifi:
        final isWifiOn = await WifiBridge.isWifiEnabled();

        if (!isWifiOn) {
          try {
            await AppSettings.openAppSettingsPanel(AppSettingsPanelType.wifi);
          } catch (_) {
            try {
              await AppSettings.openAppSettings(
                type: AppSettingsType.wifi,
                asAnotherTask: true,
              );
            } catch (_) {
              await AppSettings.openAppSettings(
                type: AppSettingsType.wireless,
                asAnotherTask: true,
              );
            }
          }
          return false;
        }
        return true;
    }
  }

  /// Internal helper to process the permission and hardware check
  static Future<bool> _verifyPermissionAndService({
    required Permission permission,
    required String hardwareName,
    required AppSettingsType settingsType,
    required bool checkHardwareService,
  }) async {
    // 1. Check and request the software permission
    PermissionStatus status = await permission.request();

    if (status.isPermanentlyDenied) {
      NotificationService.showErrorDialog(
        '$hardwareName permission is blocked. Please allow it in App Settings.',
      );
      // Route to Application Permissions page
      await AppSettings.openAppSettings(type: AppSettingsType.settings);
      return false;
    }

    if (status.isDenied) {
      NotificationService.showErrorDialog(
        '$hardwareName permission is required to continue.',
      );
      return false;
    }

    // 2. Check if the physical hardware toggle is turned ON
    if (checkHardwareService) {
      bool isServiceOn = true;

      // Safely route the hardware check. Only Location is supported natively here.
      if (permission == Permission.location) {
        isServiceOn = await Permission.location.serviceStatus.isEnabled;
      }

      if (!isServiceOn) {
        // Route directly to the hardware toggle page (e.g., GPS settings)
        await AppSettings.openAppSettings(
          type: settingsType,
          asAnotherTask:
              true, // Added here as well for consistency on custom ROMs
        );
        return false;
      }
    }

    // 3. Everything is granted and turned on
    return true;
  }
}
