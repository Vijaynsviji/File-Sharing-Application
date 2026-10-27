import 'package:flutter/services.dart';

class WifiBridge {
  static const MethodChannel _channel = MethodChannel(
    'com.vijayns.file_share/wifi',
  );

  static Future<bool> isWifiEnabled() async {
    final result = await _channel.invokeMethod<bool>('isWifiEnabled');

    if (result == null) {
      throw PlatformException(
        code: 'WIFI_CHECK_FAILED',
        message: 'Native Wi-Fi state was not returned.',
      );
    }

    return result;
  }
}
