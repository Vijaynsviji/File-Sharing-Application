import 'package:flutter/material.dart';

import '../../native_bridge/engine.dart'; // Note: cupertino.dart is usually unnecessary here

class ReceiverViewModel extends ChangeNotifier {
  Engine? engine;

  ReceiverViewModel({required this.engine});

  Future<void> startBroadCastListening() async {
    try {
      if (engine == null) return;
      print("Calling Broadcasting");
      engine!.startListening();
    } catch (e) {}
  }

  Future<void> stopBroadCastListening() async {
    try {
      if (engine == null) return;
      engine!.stopListening();
    } catch (e) {}
  }
}
