import 'dart:convert';

import 'package:file_share_application_frontend/global/Providers/EngineNotifier.dart';
import 'package:file_share_application_frontend/native_bridge/engine.dart';
import 'package:file_share_application_frontend/ui/find_near_by/find_near_by_view_model.dart';
import 'package:flutter/material.dart';

import '../../global/models/user_model.dart';

class SenderViewModel extends ChangeNotifier {
  Engine? engine;
  User? currentUser;

  bool _isLoading = false;

  SenderViewModel({required this.engine, required this.currentUser});

  get isLoading => _isLoading;

  Future<void> startBroadCasting() async {
    try {
      if (engine == null || currentUser == null) return;
      engine!.startBroadcast();
    } catch (e) {}
  }

  Future<void> stopBroadCasting() async {
    try {
      if (engine == null) return;
      engine!.stopBroadcasting();
    } catch (e) {}
  }

  Future<void> startTCPListening() async {
    try {
      if (engine == null) return;
      engine!.startTcpListening();
    } catch (e) {}
  }

  Future<void> stopTCPListening() async {
    try {
      if (engine == null) return;
      engine!.stopTcpListening();
    } catch (e) {}
  }

  Future<void> startBroadCastingAndTCPListening() async {
    try {
      startBroadCasting();
      startTCPListening();
    } catch (e) {}
  }

  Future<void> stopAllBroadCastingAndListening() async {
    try {
      stopBroadCasting();
      stopTCPListening();
    } catch (e) {}
  }
}
