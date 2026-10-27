import 'dart:convert';

import 'package:file_share_application_frontend/global/models/peer_device.dart';

import '../global/Providers/DiscoveryNotifier.dart';

class NativeEventHandler {
  Discoverynotifier? discoverynotifier;

  NativeEventHandler({required this.discoverynotifier});

  void handleEventReceived(String jsonString) {
    print("Json String: " + jsonString);
    if (jsonString.isEmpty) return;

    Map<String, dynamic> parsedMap = jsonDecode(jsonString);
    final eventData = parsedMap['eventData'];
    print("Event Received for Handler: ");
    PeerDevice peerDeviceFromJson = PeerDevice.fromMap(eventData);
    // if (peerDeviceFromJson.deviceUniqueId.isEmpty || discoverynotifier == null)
    //   return;
    print("discovery Notifier: " + discoverynotifier.toString());
    discoverynotifier!.addNewOnlinePeerDevice(
      peerDeviceFromJson,
      eventData['IPAddress'],
    );
  }
}
