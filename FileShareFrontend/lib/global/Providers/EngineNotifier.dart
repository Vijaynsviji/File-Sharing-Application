import 'dart:convert';

import 'package:file_share_application_frontend/core/notifications/notification_type.dart';
import 'package:file_share_application_frontend/global/Providers/CurrentUserNotifier.dart';
import 'package:file_share_application_frontend/global/Providers/DiscoveryNotifier.dart';
import 'package:file_share_application_frontend/native_bridge/native_event.dart';
import 'package:flutter/cupertino.dart';

import '../../native_bridge/engine.dart';
import '../../native_bridge/nativ_event_handler.dart';

class EngineNotifier extends ChangeNotifier {
  Engine? _engine;
  String? _errorMessage;
  // Discoverynotifier? _discoverynotifier;

  // Getters for the UI
  Engine? get engine => _engine;
  String? get errorMessage => _errorMessage;
  bool get hasError => _errorMessage != null;

  EngineNotifier(
    Discoverynotifier discoverynotifier,
    Currentusernotifier currentNotifier,
  ) {
    print("Engine Notifer: " + discoverynotifier.toString());
    _initializeEngine(discoverynotifier, currentNotifier);
  }

  void _initializeEngine(
    Discoverynotifier discoverynotifier,
    Currentusernotifier currentNotifier,
  ) {
    try {
      // Attempt once-off setup safely
      _engine = Engine();
      final currentUser = currentNotifier.currentUser;
      if (currentUser == null) {
        throw ("Not able to find Current User");
      }
      final userJsonString = currentUser!.toJson();
      _engine?.intialiseCurrentUserAndDevice(jsonEncode(userJsonString));
      NativeEventHandler nativeEventHandler = NativeEventHandler(
        discoverynotifier: discoverynotifier,
      );
      NativeEventReceiver nativeEventReceiver = NativeEventReceiver();
      if (_engine != null) {
        nativeEventReceiver.initialize(_engine!, nativeEventHandler);
      }
      _errorMessage = null;
    } catch (e) {
      _engine = null;
      _errorMessage = e.toString();
      debugPrint("Engine Setup Error: $e");
      NotificationService.showErrorDialog(e.toString());
    }
    notifyListeners(); // Notify UI about success or failure
  }

  @override
  void dispose() {
    // Make sure we clean up the native pointer when the provider is destroyed
    _engine?.dispose();
    super.dispose();
  }
}
