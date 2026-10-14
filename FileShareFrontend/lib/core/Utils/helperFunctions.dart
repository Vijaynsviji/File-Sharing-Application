import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';

Future<({String deviceName, String deviceType})> getDeviceInfo() async {
  final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

  if (Platform.isAndroid) {
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    // FIX: Match the exact Record structure specified in the return type
    return (deviceType: "Android", deviceName: androidInfo.model);
  } else if (Platform.isIOS) {
    IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
    // FIX: Match the exact Record structure specified in the return type
    return (deviceType: "iOS", deviceName: iosInfo.name);
  } else {
    // Handling other platforms safely to avoid crashes
    return (deviceType: "Unknown", deviceName: "Unknown");
  }
}
